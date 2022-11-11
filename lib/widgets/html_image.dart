// Dart imports:
import 'dart:html';
import 'dart:ui' as ui;

// Flutter imports:
import 'package:blockie_app/data/apis/models/allowed_uri_policy.dart';
import 'package:flutter/material.dart';

class HtmlImage extends StatelessWidget {
  final String url;

  const HtmlImage({Key? key, required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final imageHtml =
        '<img src="$url" style="object-fit: contain;" width="100%" height="100%">';
    final NodeValidator validator = NodeValidatorBuilder.common()
      ..allowElement(
        'img',
        attributes: [
          'src',
          'style',
          'width',
          'height',
        ],
        uriPolicy: AllowedUriPolicy(),
      );
    //ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory('htmlImage_$url', (_) {
      return HtmlHtmlElement()
        ..style.border = 'none'
        ..style.width = "100%"
        ..style.height = "100%"
        ..style.display = "flex"
        ..style.backgroundColor = "transparent"
        ..style.justifyContent = "center"
        ..style.alignItems = "center"
        ..setInnerHtml(imageHtml, validator: validator);
    });
    return HtmlElementView(viewType: 'htmlImage_$url');
  }
}
