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

  void goToGallery(int index) async {
    final parameters = {
      GalleryParameter.index: '$index',
      GalleryParameter.imageUrls:
          jsonEncode(projectDetails.value?.imageUrls ?? []),
    };
    await Get.toNamed(Routes.gallery, parameters: parameters);
    _updateShareConfig(isDefaultConfig: false);
  }

  void goToBrandDetails(String id) async {
    final parameters = {BrandDetailsParameter.id: id};
    await Get.toNamed(Routes.brand, parameters: parameters);
    _updateShareConfig(isDefaultConfig: false);
  }

  void goToShare() async {
    final parameters = {ShareParameter.id: id, ShareParameter.isNft: 'false'};
    await Get.toNamed(Routes.share, parameters: parameters);
    _updateShareConfig(isDefaultConfig: false);
  }

  void goToWebView({required String url}) async {
    final parameters = {WebViewParameter.url: url};
    await Get.toNamed(Routes.webView, parameters: parameters);
    _updateShareConfig(isDefaultConfig: false);
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
    Get.projectDetailsMintedNftDialog(
      nft: nft,
      buttonOnTap: () {
        Get.back();
        final parameters = {"uid": nft.uid};
        Get.toNamed(Routes.nft, parameters: parameters);
      },
    );
  }
}
