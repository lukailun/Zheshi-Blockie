// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/app/modules/update_gender/controllers/update_gender_controller.dart';
import 'package:blockie_app/app/modules/update_gender/views/update_gender_item_tile.dart';
import 'package:blockie_app/data/models/app_theme_data.dart';
import 'package:blockie_app/data/models/gender.dart';
import 'package:blockie_app/extensions/extensions.dart';
import 'package:blockie_app/widgets/basic_app_bar.dart';
import 'package:blockie_app/widgets/basic_elevated_button.dart';

class UpdateGenderView extends GetView<UpdateGenderController> {
  const UpdateGenderView({super.key});

  @override
  Widget build(BuildContext context) {
    final Widget title = const Text('编辑性别')
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
          onTap: controller.updateGender,
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
    final genderView = SizedBox(
      width: double.infinity,
      // height: 100,
      child: Obx(
        () => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            UpdateGenderItemTile(
              title: '男',
              isSelected: controller.selectedGender.value == Gender.male,
              onTap: () => controller.selectedGender.value = Gender.male,
            ),
            UpdateGenderItemTile(
              title: '女',
              isSelected: controller.selectedGender.value == Gender.female,
              onTap: () => controller.selectedGender.value = Gender.female,
            ),
          ],
        ),
      ),
    ).outlined().paddingOnly(top: 29);
    return Scaffold(
      backgroundColor: AppThemeData.primaryColor,
      appBar: BasicAppBar(),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: AppThemeData.primaryColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [header, genderView],
        ).paddingSymmetric(horizontal: 20),
      ),
    );
  }
}
