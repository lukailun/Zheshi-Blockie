part of 'subactivity_controller.dart';

extension SubactivityControllerRouter on SubactivityController {
  void goToProjectDetails(String id) async {
    final parameters = {ProjectDetailsParameter.id: id};
    await Get.toNamed(Routes.projectDetails, parameters: parameters);
    getSubactivity();
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
      getSubactivity();
    });
  }

  void goToRegistrationInfo(String id) async {
    final parameters = {RegistrationInfoParameter.id: id};
    await Get.toNamed(Routes.registrationInfo, parameters: parameters);
    getSubactivity();
  }

  void goToPreviewVideo(Project project, MintStatus mintStatus) async {
    final url = project.videoUrl ?? '';
    final posterUrl = project.coverUrl ?? '';
    final parameters = {
      PreviewVideoParameter.url: url,
      PreviewVideoParameter.posterUrl: posterUrl,
    };
    final toMint =
        await Get.toNamed(Routes.previewVideo, parameters: parameters);
    if (toMint == true) {
      prepareToMint(project, mintStatus);
    }
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

  void openStaffQrCodeDialog() {
    final staffQrCodeUrl = subactivity.value?.staffQrCodeUrl;
    if (staffQrCodeUrl == null) {
      return;
    }
    Get.staffQrCodeDialog(qrCode: staffQrCodeUrl);
  }
}
