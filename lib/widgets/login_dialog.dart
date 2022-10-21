// Dart imports:
import 'dart:html' as html;
import 'dart:ui' as ui;

// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:blockie_app/services/anyweb_service.dart';

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
        ..src =
            'https://zheshi.tech/public/dist/?method=${AnyWebMethod.accounts.value}'
        ..style.border = 'none';
    });
    return HtmlElementView(viewType: AnyWebMethod.accounts.value);
  }
}
