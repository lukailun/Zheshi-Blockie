// Dart imports:
import 'dart:ui';

// Flutter imports:
import 'package:blockie_app/models/app_theme_data.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/app/modules/web_view/controllers/web_view_controller.dart';
import 'package:blockie_app/app/routes/app_pages.dart';
import 'package:blockie_app/data/apis/blockie_url_builder.dart';
import 'package:blockie_app/models/user_info.dart';
import 'package:blockie_app/services/auth_service.dart';
import 'package:blockie_app/widgets/basic_one_button_dialog.dart';
import 'package:blockie_app/widgets/license_dialog.dart';
import 'package:blockie_app/widgets/login_dialog.dart';
import 'package:blockie_app/widgets/logout_dialog.dart';
import 'package:blockie_app/widgets/qr_code_dialog.dart';

extension GetDialogExtension on GetInterface {
  void oneButtonDialog({
    required String title,
    required String message,
    required String buttonTitle,
    required VoidCallback buttonOnTap,
  }) {
    Get.dialog(
      BasicOneButtonDialog(
        title: title,
        message: message,
        buttonTitle: buttonTitle,
        buttonOnTap: buttonOnTap,
      ),
      barrierColor: AppThemeData.barrierColor,
    );
  }

  void qrCodeDialog({
    required UserInfo user,
    required String qrCode,
  }) {
    Get.dialog(
      QrCodeDialog(
        user: user,
        qrCode: qrCode,
      ),
      barrierColor: AppThemeData.barrierColor,
    );
  }

  void licenseDialog({
    required VoidCallback onLoginSuccess,
  }) {
    Get.dialog(
      LicenseDialog(
        onTermsOfServiceTap: () {
          final parameters = {
            WebViewParameter.url: BlockieUrlBuilder.buildTermsOfServiceUrl(),
          };
          Get.toNamed(Routes.webView, parameters: parameters);
        },
        onPrivacyPolicyTap: () {
          final parameters = {
            WebViewParameter.url: BlockieUrlBuilder.buildPrivacyPolicyUrl(),
          };
          Get.toNamed(Routes.webView, parameters: parameters);
        },
        onPositiveButtonTap: () {
          Get.back();
          _loginDialog(onLoginSuccess: onLoginSuccess);
        },
        onNegativeButtonTap: () => Get.back(),
      ),
      barrierColor: AppThemeData.barrierColor,
    );
  }

  void logoutDialog({
    required VoidCallback onLogoutSuccess,
  }) {
    AuthService.to.listenLogout(onLogoutSuccess: onLogoutSuccess);
    Get.dialog(
      const LogoutDialog(),
      barrierColor: AppThemeData.barrierColor,
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
