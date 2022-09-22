import 'dart:html';

import 'package:blockie_app/common/app_theme_data.dart';
import 'package:blockie_app/extensions/extensions.dart';
import 'package:blockie_app/widgets/basic_elevated_button.dart';
import 'package:blockie_app/widgets/screen_bound.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../widgets/basic_app_bar.dart';
import '../controllers/update_avatar_controller.dart';
import 'dart:ui' as ui;

class UpdateAvatarView extends GetView<UpdateAvatarController> {
  const UpdateAvatarView({super.key});

  @override
  Widget build(BuildContext context) {
    const html = '<input type="file" accept="image/*">';
    //ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory('blockie_moment', (int viewId) {
      return HtmlHtmlElement()
        ..style.border = 'none'
        ..setInnerHtml(html);
    });
    Widget webView = SizedBox(
      width: 300,
      height: 50,
      child: const HtmlElementView(viewType: 'blockie_moment'),
    );
    final Widget title = const Text('修改昵称')
        .textColor(Colors.white)
        .fontSize(24)
        .fontWeight(FontWeightCompat.semiBold)
        .textShadow(color: const Color(0x40000000), offset: const Offset(2, 2));
    final saveButton = SizedBox(
      width: 105,
      height: 36,
      child: BasicElevatedButton(
        title: '保存',
        onTap: () => Get.back(),
      ),
    );
    final header = Row(
      children: [
        title,
        const Expanded(child: SizedBox()),
        saveButton,
      ],
    );
    return ScreenBoundary(
      padding: 0,
      body: Scaffold(
        backgroundColor: Colors.black,
        appBar: const BasicAppBar(title: '我的头像'),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.black,
          child: Column(
            children: [
              const Expanded(child: SizedBox()),
              AspectRatio(
                aspectRatio: 1,
                child: Image.network(
                  controller.initialAvatar.value,
                  width: double.infinity,
                  fit: BoxFit.fill,
                ),
              ).paddingOnly(bottom: 20),
              Container(
                height: 224,
                decoration: const BoxDecoration(
                  color: AppThemeData.primaryColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                  ),
                ),
                child: Column(
                  children: [
                    // SizedBox(
                    //   height: 48,
                    //   child: BasicElevatedButton(
                    //     title: '更换头像',
                    //     borderRadius: 8,
                    //     onTap: () => Get.back(),
                    //   ),
                    // ).paddingSymmetric(horizontal: 22, vertical: 6),
                    webView,
                    SizedBox(
                      height: 48,
                      child: BasicElevatedButton(
                        title: '保存头像',
                        borderRadius: 8,
                        onTap: () {
                          downloadFile(controller.initialAvatar.value);
                        },
                      ),
                    ).paddingSymmetric(horizontal: 22, vertical: 6),
                    SizedBox(
                      height: 48,
                      child: BasicElevatedButton(
                        title: '取消',
                        borderRadius: 8,
                        showsShadow: false,
                        onTap: () => Get.back(),
                      ),
                    ).paddingSymmetric(horizontal: 22, vertical: 6),
                  ],
                ).paddingOnly(top: 14),
              )
            ],
          ),
        ),
      ),
    );
  }
}

downloadFile(url) {
  AnchorElement anchorElement = AnchorElement(href: url);
  anchorElement.download = "Flutter";
  anchorElement.click();
}
