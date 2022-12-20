part of 'settings_controller.dart';

extension SettingsControllerRouter on SettingsController {
  void goToTermsOfService() {
    final parameters = {
      WebViewParameter.url: BlockieUrlBuilder.buildTermsOfServiceUrl(),
    };
    AppRouter.toNamed(Routes.webView, parameters: parameters);
  }

  void goToPrivacyPolicy() {
    final parameters = {
      WebViewParameter.url: BlockieUrlBuilder.buildPrivacyPolicyUrl(),
    };
    AppRouter.toNamed(Routes.webView, parameters: parameters);
  }

  void goToActivitiesManagement() {
    AppRouter.toNamed(Routes.activitiesManagement);
  }

  void goToDeveloperMode() {
    AppRouter.toNamed(Routes.developerMode);
  }

  void openConfirmToLogoutDialog() {
    Get.twoButtonDialog(
      title: '提示',
      message: '确定登出吗？',
      positiveButtonTitle: '确认',
      positiveButtonOnTap: () {
        Get.back();
        openLogoutDialog();
      },
      negativeButtonTitle: '取消',
      negativeButtonOnTap: Get.back,
    );
  }

  void openLogoutDialog() {
    Get.logoutDialog(onLogoutSuccess: () async {
      await repository.logout();
      DataStorage.removeToken();
      Get.offAllNamed(Routes.activities);
    });
  }
}
