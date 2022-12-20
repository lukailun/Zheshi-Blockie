part of 'activities_controller.dart';

extension ActivitiesControllerRouter on ActivitiesController {
  void goToActivity(GetDelegate delegate, String id) {
    final parameters = {ActivityParameter.id: id};
    AppRouter.toNamed(Routes.activity, parameters: parameters);
  }

  void goToBrandDetails(String id) {
    final parameters = {BrandDetailsParameter.id: id};
    AppRouter.toNamed(Routes.brand, parameters: parameters);
  }

  void goToProfile() {
    final userValue = user.value;
    final parameters = {ProfileParameter.id: userValue?.id ?? ''};
    AppRouter.toNamed(Routes.profile, parameters: parameters);
  }

  void showLicenseDialog() {
    Get.licenseDialog(onLoginSuccess: () {
      MessageToast.showMessage("登录成功");
      getUserInfo();
    });
  }
}
