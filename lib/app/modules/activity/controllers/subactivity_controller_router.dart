part of 'subactivity_controller.dart';

extension SubactivityControllerRouter on SubactivityController {
  void goToProjectDetails(String id) async {
    final parameters = {ProjectDetailsParameter.id: id};
    await Get.toNamed(Routes.projectDetails, parameters: parameters);
    getSubactivity();
  }

  void goToProfile() async {
    final userValue = AuthService.to.user.value;
    final parameters = {ProfileParameter.id: userValue?.id ?? ''};
    await Get.toNamed(Routes.profile, parameters: parameters);
    getSubactivity();
  }

  void handleStepTap(SubactivityStep step) {
    switch (step.type) {
      case SubactivityStepType.login:
        return openLicenseDialog();
      case SubactivityStepType.registrationInfo:
        if (!AuthService.to.isLoggedIn) {
          return MessageToast.showMessage('登录后使用');
        }
        return goToRegistrationInfo(preview.id);
      case SubactivityStepType.finish:
      case SubactivityStepType.volunteer:
        return MessageToast.showMessage('系统自动判断是否${step.title}');
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

  void openQrCodeDialog() {
    final userValue = AuthService.to.user.value;
    final qrCodeValue = qrCode.value;
    if (userValue == null || qrCodeValue == null) {
      return;
    }
    Get.qrCodeDialog(
      user: userValue,
      qrCode: qrCodeValue,
      onClosed: getSubactivity,
    );
  }
}
