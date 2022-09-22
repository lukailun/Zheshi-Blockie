import 'package:blockie_app/common/app_theme_data.dart';
import 'package:blockie_app/extensions/extensions.dart';
import 'package:blockie_app/widgets/basic_elevated_button.dart';
import 'package:blockie_app/widgets/screen_bound.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../widgets/basic_app_bar.dart';
import '../controllers/update_username_controller.dart';

class UpdateUsernameView extends GetView<UpdateUsernameController> {
  const UpdateUsernameView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Widget title = const Text('修改昵称')
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
            onTap: () => controller
                .updateUsername(controller.textEditingController.text),
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
      height: 62,
      child: Center(
        child: TextField(
          controller: controller.textEditingController,
          autofocus: true,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeightCompat.semiBold,
          ),
          cursorColor: Colors.white,
          decoration: InputDecoration(
            hintText: "最多 15 个字",
            hintStyle: TextStyle(
              color: Color(0x80FFFFFF),
              fontSize: 16,
              fontWeight: FontWeightCompat.semiBold,
            ),
            border: InputBorder.none,
          ),
        ).paddingSymmetric(horizontal: 18),
      ),
    ).outlined().paddingOnly(top: 29);
    return ScreenBoundary(
      padding: 0,
      body: Scaffold(
        backgroundColor: AppThemeData.primaryColor,
        appBar: const BasicAppBar(),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          color: AppThemeData.primaryColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [header, textField],
          ).paddingSymmetric(horizontal: 20),
        ),
      ),
    );
  }
}
