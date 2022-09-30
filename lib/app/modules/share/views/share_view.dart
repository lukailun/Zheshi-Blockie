import 'package:blockie_app/app/modules/share/views/segmented_control_button.dart';
import 'package:blockie_app/models/app_theme_data.dart';
import 'package:blockie_app/widgets/basic_elevated_button.dart';
import 'package:blockie_app/widgets/screen_bound.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:blockie_app/app/modules/share/controllers/share_controller.dart';

class ShareView extends GetView<ShareController> {
  const ShareView({super.key});

  @override
  Widget build(BuildContext context) {
    final segmentedControl = SizedBox(
      height: 30,
      child: Obx(
        () => Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
                child: SegmentedControlButton(
              title: "分享海报",
              isSelected: controller.selectedIndex.value == 0,
              onTap: () => controller.selectedIndex.value = 0,
            )),
            Expanded(
                child: SegmentedControlButton(
              title: "高清原图",
              isSelected: controller.selectedIndex.value == 1,
              onTap: () => controller.selectedIndex.value = 1,
            )),
            Expanded(
                child: SegmentedControlButton(
              title: "视频动画",
              isSelected: controller.selectedIndex.value == 2,
              onTap: () => controller.selectedIndex.value = 2,
            )),
          ],
        ),
      ),
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
          child: Column(
            children: [
              segmentedControl,
              const Expanded(child: SizedBox()),
              buttons,
            ],
          ).paddingSymmetric(horizontal: 20),
        ),
      ),
    );
  }
}
