// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/app/modules/update_bio/controllers/update_bio_controller.dart';
import 'package:blockie_app/extensions/extensions.dart';
import 'package:blockie_app/data/models/app_theme_data.dart';
import 'package:blockie_app/widgets/basic_app_bar.dart';
import 'package:blockie_app/widgets/basic_elevated_button.dart';
import 'package:blockie_app/widgets/basic_text_field.dart';

class UpdateBioView extends GetView<UpdateBioController> {
  const UpdateBioView({super.key});

  @override
  Widget build(BuildContext context) {
    final Widget title = const Text('编辑简介')
        .textColor(Colors.white)
        .fontSize(24)
        .fontWeight(FontWeightCompat.semiBold)
        .textShadow(color: const Color(0x40000000), offset: const Offset(2, 2));
    final saveButton = SizedBox(
      width: 105,
      height: 36,
      child: Obx(() => BasicElevatedButton(
            title: '保存',
            isEnabled: controller.saveButtonIsEnabled(),
            onTap: () => controller.updateBio(controller.newBio.value),
          )),
    );
    final header = Row(
      children: [
        title,
        const Expanded(child: SizedBox()),
        saveButton,
      ],
    );
    final textField = SizedBox(
      width: double.infinity,
      height: 100,
      child: Center(
        child: BasicTextField(
          autofocus: true,
          maxLines: 3,
          text: controller.initialBio.value,
          onValueChanged: (text) => controller.newBio.value = text,
        ).paddingSymmetric(horizontal: 18),
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
          children: [header, textField],
        ).paddingSymmetric(horizontal: 20),
      ),
    );
  }
}
