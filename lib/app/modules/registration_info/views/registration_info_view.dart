import 'package:blockie_app/models/app_theme_data.dart';
import 'package:blockie_app/extensions/extensions.dart';
import 'package:blockie_app/widgets/basic_elevated_button.dart';
import 'package:blockie_app/widgets/screen_bound.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:blockie_app/widgets/basic_app_bar.dart';
import 'package:blockie_app/widgets/basic_text_field.dart';
import '../controllers/registration_info_controller.dart';

class RegistrationInfoView extends GetView<RegistrationInfoController> {
  const RegistrationInfoView({super.key});

  @override
  Widget build(BuildContext context) {
    final Widget title = const Text('报名信息')
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
            onTap: () => controller.updateRegistrationInfo(),
          )),
    );
    final header = Row(
      children: [
        title,
        const Expanded(child: SizedBox()),
        saveButton,
      ],
    );
    final entryNumberTextField = SizedBox(
      width: double.infinity,
      height: 62,
      child: Center(
        child: Obx(
          () => BasicTextField(
            autofocus: true,
            hintText: "如：KN9901",
            showsUnderline: true,
            text: controller.initialEntryNumber.value,
            onValueChanged: (text) => controller.newEntryNumber.value = text,
          ),
        ),
      ),
    );
    final uploadView = GestureDetector(
      onTap: () => controller.goToFaceVerification(),
      child: Center(
        child: Image.asset('images/common/add.png'),
      ).outlined(),
    );
    final photoGridView = Obx(
      () => GridView(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 1,
          mainAxisSpacing: 5,
          crossAxisSpacing: 5,
        ),
        shrinkWrap: true,
        children: controller.facePaths
                .map(
                  (it) => SizedBox(
                    width: double.infinity,
                    height: double.infinity,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        it.hostAdded,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ).outlined(),
                )
                .toList() +
            [uploadView],
      ),
    );
    return ScreenBoundary(
      padding: 0,
      body: Scaffold(
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
              _itemTitle('参赛号码'),
              entryNumberTextField,
              _itemTitle('人脸采集'),
              const Text('通过采集你人脸照片以自动捕捉你的比赛镜头片段，生成你专属的视频 NFT')
                  .textColor(const Color(0x80FFFFFF))
                  .fontWeight(FontWeightCompat.regular)
                  .fontSize(14),
              const SizedBox(height: 14),
              photoGridView,
            ],
          ).paddingSymmetric(horizontal: 20),
        ),
      ),
    );
  }

  Widget _itemTitle(String title) {
    return Text(title)
        .textColor(Colors.white)
        .fontWeight(FontWeightCompat.regular)
        .fontSize(16)
        .paddingOnly(top: 29, bottom: 5);
  }
}
