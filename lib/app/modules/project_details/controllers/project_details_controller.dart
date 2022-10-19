// Dart imports:
import 'dart:ui';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/app/modules/activity/controllers/activity_controller.dart';
import 'package:blockie_app/app/modules/project_details/models/mint_status.dart';
import 'package:blockie_app/app/modules/project_details/models/project_details.dart';
import 'package:blockie_app/app/modules/share/controllers/share_controller.dart';
import 'package:blockie_app/app/modules/web_view/controllers/web_view_controller.dart';
import 'package:blockie_app/app/routes/app_pages.dart';
import 'package:blockie_app/data/apis/blockie_url_builder.dart';
import 'package:blockie_app/data/repositories/project_repository.dart';
import 'package:blockie_app/extensions/extensions.dart';
import 'package:blockie_app/models/user_info.dart';
import 'package:blockie_app/services/anyweb_service.dart';
import 'package:blockie_app/services/auth_service.dart';
import 'package:blockie_app/utils/data_storage.dart';
import 'package:blockie_app/utils/http_request.dart';
import 'package:blockie_app/widgets/license_dialog.dart';
import '../../../../models/nft_info.dart';
import '../views/project_details_minted_nft_dialog.dart';

class ProjectDetailsController extends GetxController {
  final mintedNft = Rxn<NftInfo>();
  final showsLogin = false.obs;
  final projectDetails = Rxn<ProjectDetails>();
  final isMinting = false.obs;
  final _id = Get.parameters[ProjectDetailsParameter.id] as String;
  final _showsRule =
      Get.parameters[ProjectDetailsParameter.showsRule] as String;

  final ProjectRepository repository;

  ProjectDetailsController({required this.repository});

  @override
  void onReady() {
    super.onReady();
    _getProjectDetails();
    _listenLogin();
  }

  void _getProjectDetails() async {
    projectDetails.value = await repository.getProjectDetails(_id);
  }

  void mint(String id) async {
    if (isMinting.value) {
      return;
    }
    final mintStatus =
        projectDetails.value?.mintStatus(isMinting: isMinting.value);
    if (mintStatus == MintStatus.notLogin) {
      return openLicenseDialog();
    }
    if (mintStatus == MintStatus.mintable) {
      isMinting.value = true;
      mintedNft.value = await repository.mint(id);
      isMinting.value = false;
      if (mintedNft.value != null) {
        _getProjectDetails();
        openMintedNftDialog();
      }
    }
  }

  void openLicenseDialog() {
    Get.dialog(LicenseDialog(
      onTermsOfServiceTap: () =>
          goToWebView(url: BlockieUrlBuilder.buildTermsOfServiceUrl()),
      onPrivacyPolicyTap: () =>
          goToWebView(url: BlockieUrlBuilder.buildPrivacyPolicyUrl()),
      onPositiveButtonTap: () {
        Get.back();
        showsLogin.value = true;
      },
      onNegativeButtonTap: () => Get.back(),
    ));
  }

  void goToActivity() {
    if (Get.routing.previous.contains(Routes.activity)) {
      Get.back();
    } else {
      final parameters = {
        ActivityParameter.id: _id,
      };
      Get.toNamed(Routes.activity, parameters: parameters);
    }
  }

  void goToGallery(int index) {
    final parameters = {
      'index': '$index',
      'projectUid': _id,
    };
    Get.toNamed(Routes.imageView, parameters: parameters);
  }

  void goToBrand(String id) {
    final parameters = {
      'issuerUid': id,
    };
    Get.toNamed(Routes.brand, parameters: parameters);
  }

  void goToShare() {
    final parameters = {
      ShareParameter.id: _id,
      ShareParameter.isNFT: 'false',
      ShareParameter.shareTitle: '',
      ShareParameter.shareDescription: '',
      ShareParameter.shareImageUrl: '',
    };
    Get.toNamed(Routes.share, parameters: parameters);
  }

  void goToWebView({required String url}) {
    final parameters = {
      WebViewParameter.url: url,
    };
    Get.toNamed(Routes.webView, parameters: parameters);
  }

  void openHintDialog() {
    Get.oneButtonDialog(
      title: '申领规则&玩法介绍',
      message: '购买线下实体\n并使用手机号登录\n即可获得铸造资格',
      buttonTitle: '好的',
      buttonOnTap: () => Get.back(),
    );
  }

  void openMintedNftDialog() {
    if (mintedNft.value == null) {
      return;
    }
    final nft = mintedNft.value!;
    Get.dialog(
      ProjectDetailsMintedNftDialog(
        nft: nft,
        buttonOnTap: () {
          Get.back();
          final parameters = {
            "uid": nft.uid,
          };
          Get.toNamed(Routes.nft, parameters: parameters);
        },
      ),
      barrierColor: const Color(0x80FFFFFF),
    );
  }

  void _listenLogin() async {
    AnyWebService.to.accountsCode.listen((event) {
      if (event.isSuccessful) {
        _login(event.data as String);
      } else {
        showsLogin.value = false;
      }
    });
  }

  void _login(String code) async {
    try {
      Map<String, dynamic> res = await HttpRequest.login(code);
      String token = res['token'];
      UserInfo userInfo = res['user'];
      DataStorage.setToken(token);
      DataStorage.setUserUid(userInfo.uid);
      AuthService.to.updateUserInfo(userInfo);
      showsLogin.value = false;
      // _getActivity();
    } catch (e) {
      if (DataStorage.getToken() != null) {
        UserInfo userInfo =
            await HttpRequest.getUserInfo(DataStorage.getToken()!);
        AuthService.to.updateUserInfo(userInfo);
        showsLogin.value = false;
      }
    }
  }
}

class ProjectDetailsParameter {
  static const id = "id";
  static const showsRule = "showsRule";
}
