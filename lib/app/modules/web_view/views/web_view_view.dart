// Dart imports:
import 'dart:html' as html;
import 'dart:ui' as ui;

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/app/modules/web_view/controllers/web_view_controller.dart';
import 'package:blockie_app/models/app_theme_data.dart';
import 'package:blockie_app/widgets/basic_app_bar.dart';

class WebViewView extends GetView<WebViewController> {
  const WebViewView({super.key});

  @override
  Widget build(BuildContext context) {
    const viewType = 'web_view';
    //ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(viewType, (int viewId) {
      return html.IFrameElement()
        ..style.width = '100%'
        ..style.height = '100%'
        ..src = controller.url
        ..style.border = 'none';
    });
    const webView = HtmlElementView(viewType: viewType);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: BasicAppBar(),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        child: webView,
      ),
    );
  }
}
