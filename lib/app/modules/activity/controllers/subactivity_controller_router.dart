part of 'subactivity_controller.dart';

extension SubactivityControllerRouter on SubactivityController {
  void goToProjectDetails(String id) async {
    final parameters = {ProjectDetailsParameter.id: id};
    await Get.toNamed(Routes.projectDetails, parameters: parameters);
    _getSubactivity();
  }

  void handleStepTap(SubactivityStep step) {
    switch (step.id) {
      case 'login':
        return openLicenseDialog();
      case 'signup':
        return goToRegistrationInfo(preview.id);
      case 'finished_match':
        return;
      default:
        return;
    }
  }

  void openLicenseDialog() {
    Get.licenseDialog(onLoginSuccess: () {
      MessageToast.showMessage('登录成功');
      _getSubactivity();
    });
  }

  void goToRegistrationInfo(String id) async {
    final parameters = {RegistrationInfoParameter.id: id};
    await Get.toNamed(Routes.registrationInfo, parameters: parameters);
    _getSubactivity();
  }

  void goToPreviewVideo(String url, String posterUrl) {
    final parameters = {
      PreviewVideoParameter.url: url,
      PreviewVideoParameter.posterUrl: posterUrl,
    };
    Get.toNamed(Routes.previewVideo, parameters: parameters);
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
