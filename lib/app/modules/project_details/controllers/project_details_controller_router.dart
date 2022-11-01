part of 'project_details_controller.dart';

extension ProjectDetailsControllerRouter on ProjectDetailsController {
  void goToActivity() {
    if (Get.routing.previous.contains(Routes.activity)) {
      return Get.back();
    }
    final parameters = {
      ActivityParameter.id: projectDetails.value?.activityId ?? '',
    };
    Get.offAndToNamed(Routes.activity, parameters: parameters);
  }

  void goToGallery(int index) {
    final parameters = {
      GalleryParameter.index: '$index',
      GalleryParameter.imageUrls:
          jsonEncode(projectDetails.value?.imageUrls ?? []),
    };
    Get.toNamed(Routes.gallery, parameters: parameters);
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
    final introduction = projectDetails.value?.introduction;
    if (introduction == null) {
      return;
    }
    Get.oneButtonDialog(
      title: '申领规则&玩法介绍',
      message: introduction,
      buttonTitle: '好的',
      buttonOnTap: () => Get.back(),
    );
  }

  void openMintCheckCodeDialog({
    required String id,
    required String checkCode,
  }) {
    Get.mintCheckCodeDialog(
      checkCode: checkCode,
      onSuccess: () => _mint(id),
    );
  }

  void openLicenseDialog() {
    Get.licenseDialog(onLoginSuccess: () {
      MessageToast.showMessage('登录成功');
      _getProjectDetails();
    });
  }

  void openMintedNftDialog() {
    final nft = mintedNft.value;
    if (nft == null) {
      return;
    }
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
}
