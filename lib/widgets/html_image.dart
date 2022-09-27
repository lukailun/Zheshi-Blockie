import 'dart:html';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

import '../models/allowed_uri_policy.dart';

class HtmlImage extends StatelessWidget {
  final String url;

  const HtmlImage({Key? key, required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final avatarImageHtml =
        '<img src="$url" object-fit="cover" display="block" height="100%" width="100%">';
    final NodeValidator validator = NodeValidatorBuilder.common()
      ..allowElement(
        'img',
        attributes: [
          'src',
          'object-fit',
          'display',
          'height',
          'width',
        ],
        uriPolicy: AllowedUriPolicy(),
      );
    //ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory('avatarImage_$url', (_) {
      return HtmlHtmlElement()
        ..style.border = 'none'
        ..style.width = "%100"
        ..style.height = "%100"
        ..setInnerHtml(avatarImageHtml, validator: validator);
    });
    return HtmlElementView(viewType: 'avatarImage_$url');
  }
}
