// Package imports:
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

// Project imports:
import 'package:blockie_app/app/modules/settings/views/logout_dialog.dart';
import 'package:blockie_app/app/modules/web_view/controllers/web_view_controller.dart';
import 'package:blockie_app/app/routes/app_pages.dart';
import 'package:blockie_app/data/apis/blockie_url_builder.dart';
import 'package:blockie_app/data/repositories/account_repository.dart';
import 'package:blockie_app/extensions/extensions.dart';
import 'package:blockie_app/services/auth_service.dart';

class SettingsController extends GetxController {
  final AccountRepository repository;
  final initialPhoneNumber = (AuthService.to.userInfo.value?.phone ?? "").obs;
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

  void goToProjectManagement() {
    Get.toNamed(Routes.projectManagement);
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
      Get.offAllNamed(Routes.initial);
    });
  }

  void _getVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    version.value = packageInfo.version;
  }
}
