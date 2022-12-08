// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/app/modules/activity/models/project.dart';
import 'package:blockie_app/app/modules/activity/models/subactivity.dart';
import 'package:blockie_app/app/modules/activity/models/subactivity_preview.dart';
import 'package:blockie_app/app/modules/activity/models/subactivity_step_type.dart';
import 'package:blockie_app/app/modules/activity/models/video_status.dart';
import 'package:blockie_app/app/modules/activity/views/staff_qr_code_dialog.dart';
import 'package:blockie_app/app/modules/nft_details/controllers/nft_details_controller.dart';
import 'package:blockie_app/app/modules/profile/controllers/profile_controller.dart';
import 'package:blockie_app/app/modules/profile/views/qr_code_dialog.dart';
import 'package:blockie_app/app/modules/project_details/controllers/project_details_controller.dart';
import 'package:blockie_app/app/modules/project_details/views/project_details_minted_nft_dialog.dart';
import 'package:blockie_app/app/modules/registration_info/controllers/registration_info_controller.dart';
import 'package:blockie_app/app/routes/app_pages.dart';
import 'package:blockie_app/data/models/mint_status.dart';
import 'package:blockie_app/data/models/nft_details.dart';
import 'package:blockie_app/data/models/project_status.dart';
import 'package:blockie_app/data/models/subactivity_step.dart';
import 'package:blockie_app/data/repositories/account_repository.dart';
import 'package:blockie_app/data/repositories/project_repository.dart';
import 'package:blockie_app/extensions/extensions.dart';
import 'package:blockie_app/services/auth_service.dart';
import 'package:blockie_app/utils/data_storage.dart';
import 'package:blockie_app/widgets/basic_two_button_dialog.dart';
import 'package:blockie_app/widgets/license_dialog.dart';
import 'package:blockie_app/widgets/loading_indicator.dart';
import 'package:blockie_app/widgets/message_toast.dart';

part 'subactivity_controller_router.dart';

class SubactivityController extends GetxController {
  final AccountRepository accountRepository;
  final ProjectRepository projectRepository;
  final SubactivityPreview preview;

  final subactivity = Rxn<Subactivity>();
  final mintStatuses = <MintStatus>[].obs;
  final mintedNftDetails = Rxn<NftDetails>();
  final qrCode = Rxn<String>();

  SubactivityController({
    required this.accountRepository,
    required this.projectRepository,
    required this.preview,
  });

  @override
  void onReady() {
    super.onReady();
    getUserInfo();
  }

  void getUserInfo() async {
    if ((DataStorage.getToken() ?? '').isNotEmpty) {
      final user = await accountRepository.getUserInfo();
      AuthService.to.userInfo.value = user;
      AuthService.to.login();
      getSubactivity();
    } else {
      AuthService.to.userInfo.value = null;
      AuthService.to.logout();
      getSubactivity();
    }
  }

  void prepareToMint(Project project, MintStatus mintStatus) async {
    if (mintStatus == MintStatus.minting) {
      return;
    }
    if (mintStatus == MintStatus.notLogin) {
      return openLicenseDialog();
    }
    if (mintStatus == MintStatus.runOut) {
      return goToProfile();
    }
    if (mintStatus == MintStatus.needToClaimSouvenir) {
      if ((qrCode.value ?? '').isNotEmpty) {
        return openQrCodeDialog();
      }
      return getQrCode();
    }
    if (mintStatus == MintStatus.mintable) {
      return mint(project.id);
    }
  }

  void mint(String id) async {
    final subactivityValue = subactivity.value;
    if (subactivityValue == null) {
      return;
    }
    Get.loadingIndicatorDialog();
    mintedNftDetails.value = await projectRepository.mint(id);
    Get.back();
    if (mintedNftDetails.value != null) {
      getSubactivity();
      openMintedNftDialog();
    }
  }

  void getQrCode() async {
    qrCode.value = await accountRepository.getQrCode();
    if ((qrCode.value ?? '').isNotEmpty) {
      openQrCodeDialog();
    }
  }

  void getSubactivity() async {
    subactivity.value = await projectRepository.getSubactivity(preview.id);
    final subactivityValue = subactivity.value;
    if (subactivityValue == null) {
      return;
    }
    _updateMintStatuses(subactivity: subactivityValue, isMinting: false);
  }

  Future<bool> submitToFinish({
    required String id,
  }) async {
    return await projectRepository.submitToFinish(id);
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
          if (it.isQualified) {
            return MintStatus.notStarted;
          } else {
            return MintStatus.notStartedAndUnqualified;
          }
        case ProjectStatus.ongoing:
          if (!subactivity.allStepsCompleted) {
            return MintStatus.stepNotCompleted;
          }
          if (it.isBlockieNft) {
            if (it.videoStatus == VideoStatus.unrecorded ||
                it.videoStatus == VideoStatus.inProcess) {
              return MintStatus.generating;
            }
            if (it.videoStatus == VideoStatus.failed) {
              return MintStatus.generationFailed;
            }
          }
          if (it.needToClaimSouvenir) {
            return MintStatus.needToClaimSouvenir;
          }
          if (it.isQualified) {
            if (it.mintChances > 0) {
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
