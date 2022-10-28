// Dart imports:
import 'dart:html';
import 'dart:ui' as ui;

// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import '../data/apis/models/allowed_uri_policy.dart';

class HtmlImage extends StatelessWidget {
  final String url;

  const HtmlImage({Key? key, required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final imageHtml =
        '<img src="$url" object-fit="contain" display="block" width="100%">';
    final NodeValidator validator = NodeValidatorBuilder.common()
      ..allowElement(
        'img',
        attributes: [
          'src',
          'object-fit',
          'display',
          'width',
        ],
        uriPolicy: AllowedUriPolicy(),
      );
    //ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory('htmlImage_$url', (_) {
      return HtmlHtmlElement()
        ..style.border = 'none'
        ..style.width = "%100"
        ..style.height = "%100"
        ..style.display = "flex"
        ..style.justifyContent = "center"
        ..style.alignItems = "center"
        ..setInnerHtml(imageHtml, validator: validator);
    });
    return HtmlElementView(viewType: 'htmlImage_$url');
  }
}
