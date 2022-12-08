// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/app/modules/update_avatar/controllers/update_avatar_controller.dart';
import 'package:blockie_app/data/models/app_theme_data.dart';
import 'package:blockie_app/widgets/basic_app_bar.dart';
import 'package:blockie_app/widgets/basic_elevated_button.dart';
import 'package:blockie_app/widgets/blur.dart';
import 'package:blockie_app/widgets/html_image.dart';

class UpdateAvatarView extends GetView<UpdateAvatarController> {
  const UpdateAvatarView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppThemeData.primaryColor,
      appBar: BasicAppBar(title: '我的头像'),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Obx(
          () => Column(
            children: [
              Expanded(
                child: Center(
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: HtmlImage(
                      url: controller.selectedAvatarData.value.isEmpty
                          ? controller.initialAvatar.value
                          : controller.selectedAvatarData.value,
                      objectFit: 'cover',
                    ),
                  ).paddingOnly(bottom: 20),
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                    border: Border(
                        top: BorderSide(color: Colors.white24, width: 1))),
                width: double.infinity,
                height: 224,
                child: ClipRect(
                  child: Blur(
                    blurColor: const Color(0x10FFFFFF),
                    colorOpacity: 0.05,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 48,
                          child: BasicElevatedButton(
                            title: '更换头像',
                            borderRadius: 8,
                            textColor: Colors.white,
                            textFontSize: 16,
                            onTap: controller.chooseImage,
                          ),
                        ).paddingSymmetric(vertical: 6),
                        SizedBox(
                          height: 48,
                          child: BasicElevatedButton(
                            title: '保存头像',
                            borderRadius: 8,
                            textColor: Colors.white,
                            textFontSize: 16,
                            isEnabled: controller.selectedAvatarData.isNotEmpty,
                            onTap: controller.updateAvatar,
                          ),
                        ).paddingSymmetric(vertical: 6),
                        SizedBox(
                          height: 48,
                          child: BasicElevatedButton(
                            title: '取消',
                            borderRadius: 8,
                            showsBorder: false,
                            showsShadow: false,
                            backgroundColor: Colors.transparent,
                            textColor: Colors.white,
                            textFontSize: 16,
                            onTap: controller.back,
                          ),
                        ).paddingSymmetric(vertical: 6),
                      ],
                    ).paddingSymmetric(horizontal: 22, vertical: 14),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
