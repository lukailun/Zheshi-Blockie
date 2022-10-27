// Dart imports:
import 'dart:ui';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/app/modules/share/controllers/share_controller.dart';
import 'package:blockie_app/extensions/extensions.dart';
import 'package:blockie_app/models/app_theme_data.dart';
import 'package:blockie_app/widgets/basic_app_bar.dart';
import 'package:blockie_app/widgets/html_image.dart';
import 'package:blockie_app/widgets/segmented_control/segmented_control.dart';

class ShareView extends GetView<ShareController> {
  const ShareView({super.key});

  @override
  Widget build(BuildContext context) {
    final segmentedControl = SegmentedControl(
      items: controller.segmentedControlItems,
      selectedIndex: controller.selectedIndex.value,
      onSegmentSelected: (index) {
        controller.selectedIndex.value = index;
      },
    );
    final saveHintView = Container(
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
            child: const Text('长按图片保存')
                .textColor(Colors.white)
                .fontSize(14)
                .fontWeight(FontWeightCompat.regular),
          ),
        ),
      ),
    );
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: BasicAppBar(),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        child: Obx(
          () => Column(
            children: [
              segmentedControl,
              Expanded(
                child: Center(
                  child: () {
                    final imageUrl = controller.selectedIndex.value == 0
                        ? controller.posterPath.value.hostAdded
                        : controller.path.value.hostAdded;
                    return Stack(
                      children: [
                        Center(
                          child: CachedNetworkImage(
                            imageUrl: imageUrl,
                            fit: BoxFit.contain,
                          ).paddingAll(30),
                        ),
                        Opacity(
                          opacity: 0.01,
                          alwaysIncludeSemantics: true,
                          child: HtmlImage(url: imageUrl).paddingAll(30),
                        ),
                      ],
                    );
                  }(),
                ),
              ),
              saveHintView,
            ],
          ),
        ),
      ),
    );
  }
}
