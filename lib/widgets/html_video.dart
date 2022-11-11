// Dart imports:
import 'dart:html';
import 'dart:ui' as ui;

// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:blockie_app/data/apis/models/allowed_uri_policy.dart';

class HtmlVideo extends StatelessWidget {
  final String url;
  final String? posterUrl;
  final bool autoplay;
  final bool muted;
  final bool loop;

  const HtmlVideo({
    Key? key,
    required this.url,
    this.posterUrl,
    this.autoplay = true,
    this.muted = false,
    this.loop = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final imageHtml =
        '<video controls poster="${posterUrl ?? ''}"${autoplay ? ' autoplay ' : ' '}${muted ? ' muted ' : ' '}${loop ? ' loop ' : ' '}type="video/mp4" src="$url" style="object-fit: contain;" width="100%" height="100%">';
    final NodeValidator validator = NodeValidatorBuilder.common()
      ..allowElement(
        'video',
        attributes: [
          'src',
          'controls',
          'autoplay',
          'muted',
          'loop',
          'type',
          'style',
          'width',
          'height',
        ],
        uriPolicy: AllowedUriPolicy(),
      );
    //ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory('htmlVideo_$url', (_) {
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
    return HtmlElementView(viewType: 'htmlVideo_$url');
  }
}
