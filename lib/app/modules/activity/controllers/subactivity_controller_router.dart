part of 'subactivity_controller.dart';

extension SubactivityControllerRouter on SubactivityController {
  void goToProjectDetails(String id) async {
    final parameters = {ProjectDetailsParameter.id: id};
    await AppRouter.toNamed(Routes.projectDetails, parameters: parameters);
    getSubactivity();
  }

  void goToProfile() async {
    final userValue = AuthService.to.userInfo.value;
    final parameters = {ProfileParameter.id: userValue?.id ?? ''};
    await AppRouter.toNamed(Routes.profile, parameters: parameters);
    getSubactivity();
  }

  void handleStepTap(Subactivity subactivity, SubactivityStep step) {
    if (step.type != SubactivityStepType.login && !AuthService.to.isLoggedIn) {
      return MessageToast.showMessage('登录后使用');
    }
    switch (step.type) {
      case SubactivityStepType.login:
        return openLicenseDialog();
      case SubactivityStepType.register:
        return goToRegistrationInfo(preview.id);
      case SubactivityStepType.pay:
        return goToOrderCreation(preview.id);
      case SubactivityStepType.finish:
      case SubactivityStepType.volunteer:
        return MessageToast.showMessage('系统自动判断是否${step.title}');
      case SubactivityStepType.submitToFinish:
        final otherStepsCompleted = subactivity.steps
            .where((it) => it.type != step.type)
            .every((it) => it.isCompleted);
        if (!otherStepsCompleted) {
          return MessageToast.showMessage('请先完成其他${step.category}');
        }
        return Get.twoButtonDialog(
          title: '提示',
          message: '确定已经完成${step.category}: ${step.title}，提交后不可修改',
          positiveButtonTitle: '确认',
          positiveButtonOnTap: () async {
            final isSuccessful = await submitToFinish(id: subactivity.id);
            Get.back();
            if (isSuccessful) {
              getSubactivity();
            }
          },
          negativeButtonTitle: '取消',
          negativeButtonOnTap: Get.back,
        );
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
    await AppRouter.toNamed(Routes.registrationInfo, parameters: parameters);
    getSubactivity();
  }

  void goToOrderCreation(String id) async {
    final parameters = {OrderCreationParameter.id: id};
    await AppRouter.toNamed(Routes.orderCreation, parameters: parameters);
    getSubactivity();
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
    final userValue = AuthService.to.userInfo.value;
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
