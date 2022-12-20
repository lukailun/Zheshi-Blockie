// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/app/modules/update_birthday/controllers/update_birthday_controller.dart';
import 'package:blockie_app/data/models/app_theme_data.dart';
import 'package:blockie_app/extensions/extensions.dart';
import 'package:blockie_app/widgets/basic_app_bar.dart';
import 'package:blockie_app/widgets/basic_elevated_button.dart';

class UpdateBirthdayView extends GetView<UpdateBirthdayController> {
  const UpdateBirthdayView({super.key});

  @override
  Widget build(BuildContext context) {
    final Widget title = const Text('编辑生日')
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
          onTap: controller.updateBirthday,
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
    final birthdayView = GestureDetector(
      onTap: () => controller.birthdayOnTap(context),
      behavior: HitTestBehavior.translucent,
      child: SizedBox(
        width: double.infinity,
        // height: 100,
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
                      const Text('生日')
                          .textColor(Colors.white)
                          .fontWeight(FontWeightCompat.regular)
                          .fontSize(16),
                      const Spacer(flex: 1),
                      Visibility(
                        visible: controller.selectedBirthday.value != null,
                        replacement: const Text('选择你的生日')
                            .textColor(const Color(0xB2FFFFFF))
                            .fontWeight(FontWeightCompat.regular)
                            .fontSize(16),
                        child: Text(
                                controller.selectedBirthday.value?.dateString ??
                                    '')
                            .textColor(Colors.white)
                            .fontWeight(FontWeightCompat.regular)
                            .fontSize(16),
                      ),
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
                      const Text('星座')
                          .textColor(Colors.white)
                          .fontWeight(FontWeightCompat.regular)
                          .fontSize(16),
                      const Spacer(flex: 1),
                      Visibility(
                        visible: controller.selectedBirthday.value != null,
                        replacement: const Text('你的星座')
                            .textColor(const Color(0xB2FFFFFF))
                            .fontWeight(FontWeightCompat.regular)
                            .fontSize(16),
                        child: Text(controller
                                    .selectedBirthday.value?.constellation ??
                                '')
                            .textColor(Colors.white)
                            .fontWeight(FontWeightCompat.regular)
                            .fontSize(16),
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
    return Scaffold(
      backgroundColor: AppThemeData.primaryColor,
      appBar: BasicAppBar(),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: AppThemeData.primaryColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [header, birthdayView],
        ).paddingSymmetric(horizontal: 20),
      ),
    );
  }
}
