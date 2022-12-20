// Dart imports:
import 'dart:html';
import 'dart:ui' as ui;

// Flutter imports:
import 'package:flutter/material.dart';

class HtmlVideo extends StatelessWidget {
  final String url;
  final String? posterUrl;
  final bool autoplay;
  final bool muted;
  final bool loop;
  final bool controls;

  const HtmlVideo({
    Key? key,
    required this.url,
    this.posterUrl,
    this.autoplay = false,
    this.muted = false,
    this.loop = true,
    this.controls = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory('htmlVideo_$url', (_) {
      return VideoElement()
        ..src = url
        ..poster = posterUrl ?? ''
        ..autoplay = autoplay
        ..muted = muted
        ..loop = loop
        ..controls = controls
        ..style.border = 'none';
    });
    return HtmlElementView(viewType: 'htmlVideo_$url');
  }
}
