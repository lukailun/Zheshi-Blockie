// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/app/modules/update_region/controllers/update_region_controller.dart';
import 'package:blockie_app/data/models/app_theme_data.dart';
import 'package:blockie_app/extensions/extensions.dart';
import 'package:blockie_app/widgets/basic_app_bar.dart';
import 'package:blockie_app/widgets/basic_elevated_button.dart';

class UpdateRegionView extends GetView<UpdateRegionController> {
  const UpdateRegionView({super.key});

  @override
  Widget build(BuildContext context) {
    final Widget title = const Text('编辑地区')
        .textColor(Colors.white)
        .fontSize(24)
        .fontWeight(FontWeightCompat.semiBold)
        .textShadow(color: const Color(0x40000000), offset: const Offset(2, 2));
    final saveButton = SizedBox(
      width: 105,
      height: 36,
      child: Obx(
        () => BasicElevatedButton(
          title: '保存',
          isEnabled: controller.saveButtonIsEnabled(),
          onTap: controller.updateRegion,
        ),
      ),
    );
    final header = Row(
      children: [
        title,
        const Spacer(flex: 1),
        saveButton,
      ],
    );
    final locationRegionView = GestureDetector(
      onTap: controller.locationRegionOnTap,
      behavior: HitTestBehavior.translucent,
      child: SizedBox(
        width: double.infinity,
        child: Obx(
          () => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: double.infinity,
                height: 50,
                child: Center(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text('定位到的位置')
                          .textColor(const Color(0xB2FFFFFF))
                          .fontWeight(FontWeightCompat.regular)
                          .fontSize(16),
                      const Spacer(flex: 1),
                    ],
                  ),
                ).paddingSymmetric(horizontal: 22),
              ),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: Center(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/update_region/location.png',
                        width: 18,
                        height: 22,
                        fit: BoxFit.contain,
                      ).paddingOnly(right: 13),
                      Expanded(
                        child: Visibility(
                          visible:
                              controller.locationRegion.value?.region != null,
                          replacement: const Text('点击开启定位')
                              .textColor(const Color(0xB2FFFFFF))
                              .fontWeight(FontWeightCompat.regular)
                              .fontSize(16),
                          child: Text(
                                  controller.locationRegion.value?.region ?? '')
                              .textColor(Colors.white)
                              .fontWeight(FontWeightCompat.regular)
                              .fontSize(16),
                        ),
                      ),
                    ],
                  ),
                ).paddingSymmetric(horizontal: 22),
              ),
            ],
          ),
        ),
      ).outlined(),
    ).paddingOnly(top: 29);
    final selectedRegionView = GestureDetector(
      onTap: () => controller.regionOnTap(context),
      behavior: HitTestBehavior.translucent,
      child: SizedBox(
        width: double.infinity,
        child: Obx(
          () => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: double.infinity,
                height: 50,
                child: Center(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text('全部')
                          .textColor(const Color(0xB2FFFFFF))
                          .fontWeight(FontWeightCompat.regular)
                          .fontSize(16),
                      const Spacer(flex: 1),
                    ],
                  ),
                ).paddingSymmetric(horizontal: 22),
              ),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: Center(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child:
                            Text(controller.selectedRegion.value?.region ?? '')
                                .textColor(Colors.white)
                                .fontWeight(FontWeightCompat.regular)
                                .fontSize(16),
                      ),
                      Image.asset(
                        'assets/images/common/arrow.png',
                        width: 20,
                        height: 20,
                        fit: BoxFit.contain,
                      ).paddingOnly(left: 5),
                    ],
                  ),
                ).paddingSymmetric(horizontal: 22),
              ),
            ],
          ),
        ),
      ).outlined(),
    ).paddingOnly(top: 34);
    return Scaffold(
      backgroundColor: AppThemeData.primaryColor,
      appBar: BasicAppBar(),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: AppThemeData.primaryColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            header,
            locationRegionView,
            selectedRegionView,
          ],
        ).paddingSymmetric(horizontal: 20),
      ),
    );
  }
}
