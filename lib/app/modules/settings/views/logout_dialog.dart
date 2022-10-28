// Dart imports:
import 'dart:html' as html;
import 'dart:ui' as ui;

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/models/app_theme_data.dart';
import 'package:blockie_app/services/anyweb_service.dart';
import 'package:blockie_app/services/auth_service.dart';
import 'package:blockie_app/widgets/loading_indicator.dart';

import '../../../../models/global.dart';

extension GetDialogExtension on GetInterface {
  void logoutDialog({
    required VoidCallback onLogoutSuccess,
  }) {
    AuthService.to.listenLogout(onLogoutSuccess: onLogoutSuccess);
    Get.dialog(
      const _LogoutDialog(),
      barrierColor: AppThemeData.barrierColor,
    );
  }
}

class _LogoutDialog extends StatelessWidget {
  const _LogoutDialog({super.key});

  @override
  Widget build(BuildContext context) {
    //ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(AnyWebMethod.logout.value,
        (int viewId) {
      return html.IFrameElement()
        ..style.width = '100%'
        ..style.height = '100%'
        ..src = '${Global.anyWebUrl}?method=${AnyWebMethod.logout.value}'
        ..style.border = 'none';
    });

    final logoutView = Stack(
      children: [
        Opacity(
          opacity: 0,
          alwaysIncludeSemantics: true,
          child: HtmlElementView(viewType: AnyWebMethod.logout.value),
        ),
        const LoadingIndicator(),
      ],
    );
    return logoutView;
  }
}
