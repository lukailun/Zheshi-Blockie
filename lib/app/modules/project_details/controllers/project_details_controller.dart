// Dart imports:
import 'dart:convert';
import 'dart:html' as html;
import 'dart:ui';

// Package imports:
import 'package:blockie_app/models/wechat_shareable.dart';
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/app/modules/activity/controllers/activity_controller.dart';
import 'package:blockie_app/app/modules/activity/models/nft_type.dart';
import 'package:blockie_app/app/modules/activity/models/video_status.dart';
import 'package:blockie_app/app/modules/brand_details/controllers/brand_details_controller.dart';
import 'package:blockie_app/app/modules/gallery/controllers/gallery_controller.dart';
import 'package:blockie_app/app/modules/project_details/models/mint_rule.dart';
import 'package:blockie_app/app/modules/project_details/models/project_details.dart';
import 'package:blockie_app/app/modules/project_details/models/project_status.dart';
import 'package:blockie_app/app/modules/project_details/views/mint_check_code_dialog.dart';
import 'package:blockie_app/app/modules/share/controllers/share_controller.dart';
import 'package:blockie_app/app/modules/web_view/controllers/web_view_controller.dart';
import 'package:blockie_app/app/routes/app_pages.dart';
import 'package:blockie_app/data/apis/models/location/location.dart';
import 'package:blockie_app/data/apis/models/wechat_share_source.dart';
import 'package:blockie_app/data/repositories/project_repository.dart';
import 'package:blockie_app/extensions/extensions.dart';
import 'package:blockie_app/models/mint_status.dart';
import 'package:blockie_app/models/user_info.dart';
import 'package:blockie_app/services/auth_service.dart';
import 'package:blockie_app/services/location_service.dart';
import 'package:blockie_app/services/wechat_service/wechat_service.dart';
import 'package:blockie_app/utils/data_storage.dart';
import 'package:blockie_app/utils/http_request.dart';
import 'package:blockie_app/widgets/basic_one_button_dialog.dart';
import 'package:blockie_app/widgets/message_toast.dart';
import '../../../../models/nft_info.dart';
import '../views/project_details_minted_nft_dialog.dart';

part 'project_details_controller_router.dart';

class ProjectDetailsController extends GetxController with WechatShareable {
  final mintedNft = Rxn<NftInfo>();
  final projectDetails = Rxn<ProjectDetails>();
  final id = Get.parameters[ProjectDetailsParameter.id] as String;

  final mintStatus = MintStatus.notLogin.obs;

  final ProjectRepository repository;

  ProjectDetailsController({required this.repository});

  @override
  void onReady() {
    super.onReady();
    _updateUser();
  }

  @override
  void onClose() {
    super.onClose();
    isDefaultConfig = true;
  }

  void _getProjectDetails() async {
    projectDetails.value = await repository.getProjectDetails(id);
    final details = projectDetails.value;
    if (details == null) {
      return;
    }
    _updateMintStatus(projectDetails: details, isMinting: false);
    isDefaultConfig = false;
  }

  void _updateMintStatus({
    required ProjectDetails projectDetails,
    required bool isMinting,
  }) {
    if (!AuthService.to.isLoggedIn) {
      mintStatus.value = MintStatus.notLogin;
      return;
    }
    if (isMinting) {
      mintStatus.value = MintStatus.minting;
      return;
    }
    switch (projectDetails.status) {
      case ProjectStatus.notStarted:
        if (projectDetails.isQualified ?? false) {
          mintStatus.value = MintStatus.notStarted;
          return;
        } else {
          mintStatus.value = MintStatus.notStartedAndUnqualified;
          return;
        }
      case ProjectStatus.ongoing:
        if (!projectDetails.allStepsCompleted) {
          mintStatus.value = MintStatus.stepNotCompleted;
          return;
        }
        if (projectDetails.isVideoNft) {
          if (projectDetails.videoStatus == VideoStatus.unrecorded ||
              projectDetails.videoStatus == VideoStatus.inProcess) {
            mintStatus.value = MintStatus.generating;
            return;
          }
          if (projectDetails.videoStatus == VideoStatus.failed) {
            mintStatus.value = MintStatus.generationFailed;
            return;
          }
        }
        if (projectDetails.isQualified ?? false) {
          if ((projectDetails.mintChances ?? 0) > 0) {
            mintStatus.value = MintStatus.mintable;
            return;
          } else {
            mintStatus.value = MintStatus.runOut;
            return;
          }
        } else {
          mintStatus.value = MintStatus.unqualified;
          return;
        }
      case ProjectStatus.expired:
        mintStatus.value = MintStatus.expired;
        return;
      case ProjectStatus.unknown:
        mintStatus.value = MintStatus.notStarted;
        return;
    }
  }

  void prepareToMint(String id) async {
    if (mintStatus.value == MintStatus.minting) {
      return;
    }
    if (mintStatus.value == MintStatus.notLogin) {
      return openLicenseDialog();
    }
    if (mintStatus.value == MintStatus.mintable) {
      final projectDetailsValue = projectDetails.value;
      if (projectDetailsValue == null) {
        return;
      }
      final mintRule = projectDetailsValue.mintRule;
      if (mintRule == null) {
        return _mint(id);
      }
      switch (mintRule) {
        case MintRule.distance:
          _updateMintStatus(
              projectDetails: projectDetailsValue, isMinting: true);
          final location = await _getLocation();
          if (location == null) {
            _updateMintStatus(
                projectDetails: projectDetailsValue, isMinting: false);
            return MessageToast.showMessage('获得此凭证需要地理位置权限');
          }
          final isInArea = projectDetailsValue.extraInfo.ruleInfo?.geometry
                  ?.isInArea(location.latitude ?? 0, location.longitude ?? 0) ??
              false;
          if (!isInArea) {
            _updateMintStatus(
                projectDetails: projectDetailsValue, isMinting: false);
            return MessageToast.showMessage('地理位置不符合要求，请联系发行方');
          }
          return _mint(id);
        case MintRule.checkCode:
          final checkCode = projectDetailsValue.extraInfo.ruleInfo?.checkCode;
          if (checkCode == null) {
            return;
          }
          return openMintCheckCodeDialog(id: id, checkCode: checkCode);
        case MintRule.registrationInfo:
          return;
      }
    }
  }

  Future<Location?> _getLocation() async {
    try {
      final location =
          await LocationService(html.window.navigator).getLocation();
      return location;
    } catch (_) {
      return null;
    }
  }

  void _mint(String id) async {
    final details = projectDetails.value;
    if (details == null) {
      return;
    }
    _updateMintStatus(projectDetails: details, isMinting: true);
    mintedNft.value = await repository.mint(id);
    if (mintedNft.value != null) {
      _getProjectDetails();
      openMintedNftDialog();
    } else {
      mintStatus.value = MintStatus.mintable;
    }
  }

  void _updateUser() async {
    if ((DataStorage.getToken() ?? "").isNotEmpty) {
      UserInfo res = await HttpRequest.getUserInfo(DataStorage.getToken()!);
      AuthService.to.user.value = res;
      AuthService.to.login();
      _getProjectDetails();
    } else {
      AuthService.to.user.value = null;
      AuthService.to.logout();
      _getProjectDetails();
    }
  }

  @override
  String title() {
    final projectDetailsValue = projectDetails.value;
    if (projectDetailsValue == null) {
      return WechatShareSource.defaults.getTitle();
    }
    return isDefaultConfig
        ? WechatShareSource.defaults.getTitle()
        : WechatShareSource.project
            .getTitle(extraInfo: projectDetailsValue.name);
  }

  @override
  String description() {
    final projectDetailsValue = projectDetails.value;
    if (projectDetailsValue == null) {
      return WechatShareSource.defaults.getTitle();
    }
    return isDefaultConfig
        ? WechatShareSource.defaults.getDescription()
        : WechatShareSource.project
            .getDescription(extraInfo: projectDetailsValue.summary);
  }

  @override
  String imageUrl() {
    final projectDetailsValue = projectDetails.value;
    if (projectDetailsValue == null) {
      return WechatShareSource.defaults.getTitle();
    }
    return isDefaultConfig
        ? WechatShareSource.defaults.getImageUrl()
        : WechatShareSource.project.getImageUrl(
            extraInfo: projectDetailsValue.coverUrl,
          );
  }

  @override
  String link() {
    final projectDetailsValue = projectDetails.value;
    if (projectDetailsValue == null) {
      return WechatShareSource.defaults.getTitle();
    }
    return isDefaultConfig
        ? WechatShareSource.defaults.getLink()
        : WechatShareSource.project.getLink(
            extraInfo:
                '${ProjectDetailsParameter.id}=${projectDetailsValue.id}');
  }
}

class ProjectDetailsParameter {
  static const id = 'id';
}
