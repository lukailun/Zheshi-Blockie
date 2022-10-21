// Dart imports:
import 'dart:html' as html;
import 'dart:ui' as ui;

// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:blockie_app/services/anyweb_service.dart';
import 'package:blockie_app/widgets/loading_indicator.dart';

class LogoutDialog extends StatelessWidget {
  const LogoutDialog({super.key});

  @override
  Widget build(BuildContext context) {
    //ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(AnyWebMethod.logout.value,
        (int viewId) {
      return html.IFrameElement()
        ..style.width = '100%'
        ..style.height = '100%'
        ..src =
            'https://zheshi.tech/public/dist/?method=${AnyWebMethod.logout.value}'
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
