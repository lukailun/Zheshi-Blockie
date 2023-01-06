part of 'activities_controller.dart';

extension ActivitiesControllerRouter on ActivitiesController {
  void goToActivity(String id) {
    final parameters = {ActivityParameter.id: id};
    AppRouter.toNamed(Routes.activity, parameters: parameters);
  }

  void getBaseInfo() {
    final currentHref = html.window.location.href;
    final userInfo = AuthService.to.userInfo.value;
    if (userInfo == null) {
      return;
    }
    final urlComponents = currentHref.split('#');
    final redirectUrlPrefix = urlComponents.first;
    final redirectUrlSuffix =
        urlComponents.length > 1 ? urlComponents[1] : null;
    final redirectUrl = BlockieUrlBuilder().buildGetWechatSilentAuthRedirectUrl(
        userInfo.id, redirectUrlPrefix, redirectUrlSuffix);
    final wechatAuthorizationUrl =
        BlockieUrlBuilder.buildWechatAuthorizationUrl(redirectUrl);
    html.window.location.href = wechatAuthorizationUrl;
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
