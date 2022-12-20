// Dart imports:
import 'dart:html';
import 'dart:ui' as ui;

// Flutter imports:
import 'package:flutter/material.dart';

class ShareButton extends StatelessWidget {
  final String id;

  const ShareButton({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory('shareButton_$id', (_) {
      return IFrameElement()
        ..style.width = '100%'
        ..style.height = '100%'
        ..style.border = 'none';
    });
    return HtmlElementView(viewType: 'shareButton_$id');
  }
}
