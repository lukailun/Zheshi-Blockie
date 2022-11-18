// Package imports:
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

// Project imports:
import 'package:blockie_app/app/modules/settings/views/logout_dialog.dart';
import 'package:blockie_app/app/modules/web_view/controllers/web_view_controller.dart';
import 'package:blockie_app/app/routes/app_pages.dart';
import 'package:blockie_app/data/apis/blockie_url_builder.dart';
import 'package:blockie_app/data/repositories/account_repository.dart';
import 'package:blockie_app/services/auth_service.dart';
import 'package:blockie_app/utils/data_storage.dart';
import 'package:blockie_app/widgets/basic_two_button_dialog.dart';

class SettingsController extends GetxController {
  final AccountRepository repository;
  final user = AuthService.to.user;
  final initialPhoneNumber = (AuthService.to.user.value?.phoneNumber ?? "").obs;
  final version = ''.obs;

  SettingsController({required this.repository});

  @override
  void onReady() {
    super.onReady();
    _getVersion();
  }

  String displayPhoneNumber(String phone) {
    if (phone.length != 11) {
      return phone;
    }
    return "${phone.substring(0, 3)}****${phone.substring(phone.length - 4)}";
  }

  void goToTermsOfService() {
    final parameters = {
      WebViewParameter.url: BlockieUrlBuilder.buildTermsOfServiceUrl(),
    };
    Get.toNamed(Routes.webView, parameters: parameters);
  }

  void goToPrivacyPolicy() {
    final parameters = {
      WebViewParameter.url: BlockieUrlBuilder.buildPrivacyPolicyUrl(),
    };
    Get.toNamed(Routes.webView, parameters: parameters);
  }

  void goToActivitiesManagement() {
    Get.toNamed(Routes.activitiesManagement);
  }

  void goToDeveloperMode() {
    Get.toNamed(Routes.developerMode);
  }

  void openConfirmToLogoutDialog() {
    Get.twoButtonDialog(
      title: '提示',
      message: '确定登出吗？',
      positiveButtonTitle: '确认',
      positiveButtonOnTap: () {
        Get.back();
        _openLogoutDialog();
      },
      negativeButtonTitle: '取消',
      negativeButtonOnTap: Get.back,
    );
  }

  void _openLogoutDialog() {
    Get.logoutDialog(onLogoutSuccess: () async {
      await repository.logout();
      DataStorage.removeToken();
      Get.offAllNamed(Routes.activities);
    });
  }

  void _getVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    version.value = packageInfo.version;
  }
}
