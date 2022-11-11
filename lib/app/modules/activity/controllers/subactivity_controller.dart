import 'package:blockie_app/app/modules/activity/models/project.dart';
import 'package:blockie_app/app/modules/activity/models/subactivity.dart';
import 'package:blockie_app/app/modules/activity/models/subactivity_preview.dart';
import 'package:blockie_app/app/modules/activity/models/subactivity_step.dart';
import 'package:blockie_app/app/modules/preview_video/controllers/preview_video_controller.dart';
import 'package:blockie_app/app/modules/project_details/controllers/project_details_controller.dart';
import 'package:blockie_app/app/modules/project_details/views/project_details_minted_nft_dialog.dart';
import 'package:blockie_app/app/modules/registration_info/controllers/registration_info_controller.dart';
import 'package:blockie_app/app/routes/app_pages.dart';
import 'package:blockie_app/data/repositories/account_repository.dart';
import 'package:blockie_app/data/repositories/project_repository.dart';
import 'package:blockie_app/app/modules/activity/models/project_status.dart';
import 'package:blockie_app/extensions/extensions.dart';
import 'package:blockie_app/models/mint_status.dart';
import 'package:blockie_app/models/nft_info.dart';
import 'package:blockie_app/models/user_info.dart';
import 'package:blockie_app/services/auth_service.dart';
import 'package:blockie_app/utils/data_storage.dart';
import 'package:blockie_app/utils/http_request.dart';
import 'package:blockie_app/widgets/loading_indicator.dart';
import 'package:blockie_app/widgets/message_toast.dart';
import 'package:get/get.dart';

part 'subactivity_controller_router.dart';

class SubactivityController extends GetxController {
  final AccountRepository accountRepository;
  final ProjectRepository projectRepository;
  final SubactivityPreview preview;

  final subactivity = Rxn<Subactivity>();
  final mintStatuses = <MintStatus>[].obs;
  final mintedNft = Rxn<NftInfo>();

  SubactivityController({
    required this.accountRepository,
    required this.projectRepository,
    required this.preview,
  });

  @override
  void onReady() {
    super.onReady();
    _updateUser();
  }

  void _updateUser() async {
    if ((DataStorage.getToken() ?? "").isNotEmpty) {
      UserInfo res = await HttpRequest.getUserInfo(DataStorage.getToken()!);
      AuthService.to.user.value = res;
      AuthService.to.login();
      _getSubactivity();
    } else {
      AuthService.to.user.value = null;
      AuthService.to.logout();
      _getSubactivity();
    }
  }

  void prepareToMint(Project project, MintStatus mintStatus) async {
    if (mintStatus == MintStatus.minting) {
      return;
    }
    if (mintStatus == MintStatus.notLogin) {
      return openLicenseDialog();
    }
    if (mintStatus == MintStatus.mintable) {
      return _mint(project.id);
    }
  }

  void _mint(String id) async {
    final subactivityValue = subactivity.value;
    if (subactivityValue == null) {
      return;
    }
    Get.loadingIndicatorDialog();
    mintedNft.value = await projectRepository.mint(id);
    Get.back();
    if (mintedNft.value != null) {
      _getSubactivity();
      openMintedNftDialog();
    }
  }

  void _getSubactivity() async {
    subactivity.value = await projectRepository.getSubactivity(preview.id);
    final subactivityValue = subactivity.value;
    if (subactivityValue == null) {
      return;
    }
    _updateMintStatuses(subactivity: subactivityValue, isMinting: false);
  }

  void _updateMintStatuses({
    required Subactivity subactivity,
    required bool isMinting,
  }) {
    if (!AuthService.to.isLoggedIn) {
      mintStatuses.value =
          subactivity.projects.map((it) => MintStatus.notLogin).toList();
      return;
    }
    if (isMinting) {
      mintStatuses.value =
          subactivity.projects.map((it) => MintStatus.minting).toList();
      return;
    }
    mintStatuses.value = subactivity.projects.map((it) {
      switch (it.status) {
        case ProjectStatus.notStarted:
          if (it.isQualified ?? false) {
            return MintStatus.notStarted;
          } else {
            return MintStatus.notStartedAndUnqualified;
          }
        case ProjectStatus.ongoing:
          if (it.isQualified ?? false) {
            if ((it.mintChances ?? 0) > 0) {
              return MintStatus.mintable;
            } else {
              return MintStatus.runOut;
            }
          } else {
            return MintStatus.unqualified;
          }
        case ProjectStatus.expired:
          return MintStatus.expired;
        case ProjectStatus.unknown:
          return MintStatus.notStarted;
      }
    }).toList();
  }
}
