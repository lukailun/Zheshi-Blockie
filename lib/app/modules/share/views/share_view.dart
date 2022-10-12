import 'package:blockie_app/widgets/segmented_control/segmented_control.dart';
import 'package:blockie_app/widgets/segmented_control/segmented_control_button.dart';
import 'package:blockie_app/extensions/extensions.dart';
import 'package:blockie_app/models/app_theme_data.dart';
import 'package:blockie_app/widgets/basic_elevated_button.dart';
import 'package:blockie_app/widgets/html_image.dart';
import 'package:blockie_app/widgets/screen_bound.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:blockie_app/app/modules/share/controllers/share_controller.dart';

class ShareView extends GetView<ShareController> {
  const ShareView({super.key});

  @override
  Widget build(BuildContext context) {
    final segmentedControl = SegmentedControl(
      items: [
        SegmentedControlButtonItem(
          ID: "分享海报".hashCode,
          title: "分享海报",
        ),
        SegmentedControlButtonItem(
          ID: "高清原图".hashCode,
          title: "高清原图",
        )
      ],
      selectedIndex: controller.selectedIndex.value,
      onSegmentSelected: (index) {
        controller.selectedIndex.value = index;
      },
    ).paddingOnly(top: 50);
    final buttons = Row(
      children: [
        Expanded(
          child: BasicElevatedButton(
            title: '返回',
            textColor: Colors.white,
            borderRadius: 8,
            onTap: () => Get.back(),
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        Expanded(
          child: BasicElevatedButton(
            title: '保存到相册',
            backgroundColor: Colors.white,
            textColor: AppThemeData.primaryColor,
            borderRadius: 8,
            onTap: () {},
          ),
        ),
      ],
    ).paddingOnly(bottom: 30);

    return ScreenBoundary(
      padding: 0,
      body: Scaffold(
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
                      return HtmlImage(url: imageUrl).paddingAll(30);
                    }(),
                  ),
                ),
                buttons,
              ],
            ),
          ).paddingSymmetric(horizontal: 20),
        ),
      ),
    );
  }
}
