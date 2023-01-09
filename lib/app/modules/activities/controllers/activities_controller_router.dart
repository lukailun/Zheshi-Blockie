part of 'activities_controller.dart';

extension ActivitiesControllerRouter on ActivitiesController {
  void goToActivity(String id) {
    final parameters = {ActivityParameter.id: id};
    AppRouter.toNamed(Routes.activity, parameters: parameters);
  }

  void goToBrandDetails(String id) {
    final parameters = {BrandDetailsParameter.id: id};
    AppRouter.toNamed(Routes.brand, parameters: parameters);
  }

  void goToProfile() {
    AppRouter.toNamed(Routes.profile);
  }

  void showLicenseDialog() {
    Get.licenseDialog(onLoginSuccess: () {
      MessageToast.showMessage("登录成功");
      getUserInfo();
    });
  }
}
