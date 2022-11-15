// Dart imports:
import 'dart:html';
import 'dart:ui' as ui;

// Flutter imports:
import 'package:flutter/material.dart';

class HtmlImage extends StatelessWidget {
  final String url;

  const HtmlImage({Key? key, required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory('htmlImage_$url', (_) {
      return ImageElement(src: url)
        ..style.objectFit = 'contain'
        ..style.border = 'none'
        ..style.width = '100%'
        ..style.height = '100%';
    });
    return HtmlElementView(viewType: 'htmlImage_$url');
  }
}
