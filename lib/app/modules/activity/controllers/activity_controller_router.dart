part of 'activity_controller.dart';

extension ActivityControllerRouter on ActivityController {
  void goToActivities() {
    Get.offAllNamed(Routes.activities);
  }

  void goToProfile() {
    Get.offNamed(Routes.profile);
  }

  void showLicenseDialog() {
    Get.licenseDialog(onLoginSuccess: () {
      MessageToast.showMessage("登录成功");
      getUserInfo();
    });
  }

  void goToRegistrationInfo(String activityId) async {
    final parameters = {
      RegistrationInfoParameter.id: activityId,
    };
    await AppRouter.toNamed(Routes.registrationInfo, parameters: parameters);
    getActivity();
  }

  void goToProjectDetails(String id) async {
    final parameters = {ProjectDetailsParameter.id: id};
    await AppRouter.toNamed(Routes.projectDetails, parameters: parameters);
    getActivity();
  }

  void goToBrandDetails(String id) async {
    final parameters = {BrandDetailsParameter.id: id};
    await AppRouter.toNamed(Routes.brand, parameters: parameters);
    getActivity();
  }
}
