import 'dart:html' as html;
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
