part of 'project_details_controller.dart';

extension ProjectDetailsControllerRouter on ProjectDetailsController {
  void goToActivities() {
    Get.offAllNamed(Routes.activities);
  }

  void goToActivity() {
    if (Get.routing.previous.contains(Routes.activity)) {
      return Get.back();
    }
    final parameters = {
      ActivityParameter.id: projectDetails.value?.activityId ?? '',
    };
    Get.offAndToNamed(Routes.activity, parameters: parameters);
  }

  void goToProfile() {
    Get.offNamed(Routes.profile);
  }

  void goToGallery(int index) async {
    final parameters = {
      GalleryParameter.index: '$index',
      GalleryParameter.imageUrls:
          jsonEncode(projectDetails.value?.imageUrls ?? []),
    };
    await AppRouter.toNamed(Routes.gallery, parameters: parameters);
    isDefaultConfig = false;
  }

  void goToBrandDetails(String id) async {
    final parameters = {BrandDetailsParameter.id: id};
    await AppRouter.toNamed(Routes.brand, parameters: parameters);
    isDefaultConfig = false;
  }

  void goToShare() async {
    final parameters = {ShareParameter.id: id, ShareParameter.isNft: 'false'};
    await AppRouter.toNamed(Routes.share, parameters: parameters);
    isDefaultConfig = false;
  }

  void goToWebView({required String url}) async {
    final parameters = {WebViewParameter.url: url};
    await AppRouter.toNamed(Routes.webView, parameters: parameters);
    isDefaultConfig = false;
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
      getProjectDetails();
    });
  }

  void openMintedNftDialog() {
    final nftDetails = mintedNftDetails.value;
    if (nftDetails == null) {
      return;
    }
    Get.projectDetailsMintedNftDialog(
      nftDetails: nftDetails,
      buttonOnTap: () {
        Get.back();
        final parameters = {NftDetailsParameter.id: nftDetails.id};
        AppRouter.toNamed(Routes.nftDetails, parameters: parameters);
        isDefaultConfig = false;
      },
    );
  }

  void openQrCodeDialog() {
    final userValue = AuthService.to.userInfo.value;
    final qrCodeValue = qrCode.value;
    if (userValue == null || qrCodeValue == null) {
      return;
    }
    Get.qrCodeDialog(
      user: userValue,
      qrCode: qrCodeValue,
      onClosed: getProjectDetails,
    );
  }
}
