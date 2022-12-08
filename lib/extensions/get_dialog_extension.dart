// Dart imports:
import 'dart:ui';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/app/modules/web_view/controllers/web_view_controller.dart';
import 'package:blockie_app/app/routes/app_pages.dart';
import 'package:blockie_app/data/apis/blockie_api/blockie_url_builder.dart';
import 'package:blockie_app/data/models/app_theme_data.dart';
import 'package:blockie_app/services/auth_service.dart';
import 'package:blockie_app/widgets/license_dialog.dart';
import 'package:blockie_app/widgets/login_dialog.dart';

extension GetDialogExtension on GetDelegate {
  void licenseDialog({
    required VoidCallback onLoginSuccess,
  }) {
    Get.dialog(
      LicenseDialog(
        onTermsOfServiceTap: () {
          final parameters = {
            WebViewParameter.url: BlockieUrlBuilder.buildTermsOfServiceUrl(),
          };
          Get.rootDelegate.toNamed(Routes.webView, parameters: parameters);
        },
        onPrivacyPolicyTap: () {
          final parameters = {
            WebViewParameter.url: BlockieUrlBuilder.buildPrivacyPolicyUrl(),
          };
          Get.rootDelegate.toNamed(Routes.webView, parameters: parameters);
        },
        onPositiveButtonTap: () {
          Get.back();
          _loginDialog(onLoginSuccess: onLoginSuccess);
        },
        onNegativeButtonTap: () => Get.back(),
      ),
      barrierColor: AppThemeData.barrierColor,
      // navigatorKey: Get.rootDelegate.navigatorKey,
    );
  }

  void _loginDialog({
    required VoidCallback onLoginSuccess,
  }) {
    AuthService.to.listenLogin(onLoginSuccess: onLoginSuccess);
    Get.dialog(
      const LoginDialog(),
      barrierColor: AppThemeData.barrierColor,
    );
  }
}
