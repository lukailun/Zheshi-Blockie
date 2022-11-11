// Dart imports:
import 'dart:ui';

// Flutter imports:
import 'package:blockie_app/widgets/message_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/app/modules/share/controllers/share_controller.dart';
import 'package:blockie_app/extensions/extensions.dart';
import 'package:blockie_app/models/app_theme_data.dart';
import 'package:blockie_app/widgets/html_image.dart';
import 'package:blockie_app/widgets/segmented_control/segmented_control.dart';

class ShareView extends GetView<ShareController> {
  const ShareView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        final isVideo = controller.selectedIndex.value == 0 &&
            controller.videoPath.isNotEmpty;
        final segmentedControl = SegmentedControl(
          items: controller.segmentedControlItems,
          selectedIndex: controller.selectedIndex.value,
          onSegmentSelected: (index) {
            controller.selectedIndex.value = index;
          },
        ).paddingOnly(top: 22, left: 56, right: 56);
        final saveHintView = GestureDetector(
          onTap: () {
            if (!isVideo) {
              return;
            }
            Clipboard.setData(
                ClipboardData(text: controller.videoPath.hostAdded));
            MessageToast.showMessage("复制成功");
          },
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0x00202020),
                  AppThemeData.primaryColor,
                ],
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              color: AppThemeData.primaryColor,
            ),
            width: double.infinity,
            height: 76,
            child: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Center(
                  child: Text(isVideo ? '点击复制链接 到默认浏览器下载' : '长按图片保存')
                      .textColor(Colors.white)
                      .fontSize(14)
                      .fontWeight(FontWeightCompat.regular),
                ),
              ),
            ),
          ),
        );
        return Scaffold(
          backgroundColor: Colors.white,
          body: Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.white,
            child: Obx(
              () => Stack(
                children: [
                  Column(
                    children: [
                      segmentedControl,
                      Expanded(
                        child: Center(
                          child: () {
                            final imageUrl = controller.selectedIndex.value ==
                                    controller.segmentedControlItems.length - 1
                                ? controller.path.value.hostAdded
                                : controller.posterPath.value.hostAdded;
                            return HtmlImage(url: imageUrl).paddingAll(30);
                          }(),
                        ),
                      ),
                      saveHintView,
                    ],
                  ),
                  Visibility(
                    visible: Get.routing.previous.isNotEmpty,
                    child: GestureDetector(
                      onTap: Get.back,
                      child: Image.asset(
                        "assets/images/app_bar/back.png",
                        width: 34,
                        height: 34,
                      ),
                    ).paddingOnly(top: 22, left: 22),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
