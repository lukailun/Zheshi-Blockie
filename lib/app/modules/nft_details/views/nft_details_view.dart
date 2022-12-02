// Dart imports:
import 'dart:html' as html;
import 'dart:ui' as ui;

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/app/modules/nft_details/controllers/nft_details_controller.dart';

class NftDetailsView extends GetView<NftDetailsController> {
  const NftDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewType = 'nft_details_${controller.id}';
    //ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(viewType, (int viewId) {
      return html.IFrameElement()
        ..style.width = '100%'
        ..style.height = '100%'
        ..style.border = 'none';
    });
    final webView = HtmlElementView(viewType: viewType);
    return Container();
  }
}
