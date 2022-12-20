// Dart imports:
import 'dart:html' as html;
import 'dart:ui' as ui;

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/data/models/app_theme_data.dart';
import 'package:blockie_app/data/models/environment.dart';
import 'package:blockie_app/services/anyweb_service.dart';
import 'package:blockie_app/services/auth_service.dart';

extension GetDialogExtension on GetInterface {
  void loginDialog({
    required VoidCallback onLoginSuccess,
  }) {
    AuthService.to.listenLogin(onLoginSuccess: onLoginSuccess);
    Get.dialog(
      const LoginDialog(),
      barrierColor: AppThemeData.barrierColor,
    );
  }
}

class LoginDialog extends StatelessWidget {
  const LoginDialog({super.key});

  @override
  Widget build(BuildContext context) {
    //ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(AnyWebMethod.accounts.value,
        (int viewId) {
      return html.IFrameElement()
        ..style.width = '100%'
        ..style.height = '100%'
        ..src = '${Environment.anyWebUrl}?method=${AnyWebMethod.accounts.value}'
        ..style.border = 'none';
    });
    return HtmlElementView(viewType: AnyWebMethod.accounts.value);
  }
}
