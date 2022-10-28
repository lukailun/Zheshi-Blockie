// Dart imports:
import 'dart:html' as html;
import 'dart:ui' as ui;

// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:blockie_app/services/anyweb_service.dart';

import '../models/global.dart';

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
        ..src = '${Global.anyWebUrl}?method=${AnyWebMethod.accounts.value}'
        ..style.border = 'none';
    });
    return HtmlElementView(viewType: AnyWebMethod.accounts.value);
  }
}
