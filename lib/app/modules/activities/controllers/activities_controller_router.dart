part of 'activities_controller.dart';

extension ActivitiesControllerRouter on ActivitiesController {
  void goToActivity(String id) {
    if (id == 'B51ywVPzYl') {
      getBaseInfo();
      return;
    }
    final parameters = {ActivityParameter.id: id};
    AppRouter.toNamed(Routes.activity, parameters: parameters);
  }

  void getBaseInfo() {
    AppRouter.toNamed(Routes.applyForRefund);
    return;
    const appId = 'wxafee24fb692df7d8';
    const blockie = 'https://s.blockie.zheshi.tech/api/v1/user';
    // const blockie = 'https://s.blockie.zheshi.tech/app/#/profile';

    // const appId = 'wx5ba17671f71b748b';
    // const blockie = 'https://www.github.com/';
    final encoded = Uri.encodeComponent(blockie);
    final url =
        'https://open.weixin.qq.com/connect/oauth2/authorize?appid=$appId&redirect_uri=$encoded&response_type=code&scope=snsapi_base#wechat_redirect';
    html.window.location.href = blockie;
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
