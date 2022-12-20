part of 'registration_info_controller.dart';

extension RegistrationInfoControllerRouter on RegistrationInfoController {
  void openConfirmToUpdateRegistrationInfoDialog() async {
    Get.twoButtonDialog(
      title: '提示',
      message: '您填写的号码是：${newEntryNumber.value}，提交后不可修改',
      positiveButtonTitle: '确认',
      positiveButtonOnTap: () {
        Get.back();
        updateRegistrationInfo();
      },
      negativeButtonTitle: '取消',
      negativeButtonOnTap: Get.back,
    );
  }

  void goToFaceVerification() async {
    final needUpdate = await AppRouter.toNamed(Routes.faceVerification);
    if (needUpdate == true) {
      getRegistrationInfo();
    }
  }
}
