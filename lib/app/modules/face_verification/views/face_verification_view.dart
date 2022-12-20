// Dart imports:
import 'dart:math';
import 'dart:typed_data';

// Flutter imports:
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/app/modules/face_verification/controllers/face_verification_controller.dart';
import 'package:blockie_app/app/modules/face_verification/views/face_verification_camera_view.dart';
import 'package:blockie_app/data/models/app_theme_data.dart';
import 'package:blockie_app/extensions/extensions.dart';
import 'package:blockie_app/widgets/basic_app_bar.dart';
import 'package:blockie_app/widgets/basic_elevated_button.dart';

class FaceVerificationView extends GetView<FaceVerificationController> {
  FaceVerificationView({super.key});

  final _faceVerificationCameraViewKey =
      GlobalKey<FaceVerificationCameraViewState>();

  @override
  Widget build(BuildContext context) {
    final title = Center(
      child: const Text('请面朝屏幕')
          .textColor(Colors.white)
          .fontSize(32)
          .fontWeight(FontWeightCompat.regular),
    );
    final subtitle = Center(
      child: const Text('需拍摄正脸清晰免冠照片')
          .textColor(Colors.white)
          .fontSize(18)
          .fontWeight(FontWeightCompat.regular),
    ).paddingOnly(top: 21);
    final cameraView = Center(
      child: SizedBox(
        width: min(256, Get.width - 120),
        height: min(256, Get.width - 120),
        child: FaceVerificationCameraView(
          key: _faceVerificationCameraViewKey,
          onPhotoTaken: (file) async {
            final bytes = await file.readAsBytes();
            final filename = "${file.path.split("/").last}.png";
            controller.uploadFacePhoto(bytes, filename);
          },
        ),
      ),
    );
    final licenseText = Center(
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: '我们承诺仅将你的人脸照片信息用于运动数据分析服务\n继续拍摄表示你已阅读并同意',
              style: _messageStyle(underline: false, opacity: 0.8),
            ),
            TextSpan(
              text: '用户条款',
              style: _messageStyle(underline: true),
              recognizer: TapGestureRecognizer()
                ..onTap = () => controller.goToTermsOfService(),
            ),
            TextSpan(
              text: '和',
              style: _messageStyle(underline: false, opacity: 0.8),
            ),
            TextSpan(
              text: '隐私政策',
              style: _messageStyle(underline: true),
              recognizer: TapGestureRecognizer()
                ..onTap = () => controller.goToPrivacyPolicy(),
            ),
          ],
        ),
        textAlign: TextAlign.center,
      ),
    ).paddingOnly(bottom: 36);
    final takePhotoButton = SizedBox(
      height: 48,
      child: Obx(
        () => BasicElevatedButton(
          borderRadius: 8,
          backgroundColor: Colors.white,
          textColor: AppThemeData.primaryColor,
          title: "同意并拍摄上传",
          isLoading: controller.isTakingPhoto.value,
          loadingIndicatorColor: AppThemeData.primaryColor,
          onTap: !controller.isTakingPhoto.value
              ? () {
                  controller.isTakingPhoto.value = true;
                  _faceVerificationCameraViewKey.currentState?.takePhoto();
                }
              : null,
        ),
      ),
    ).paddingOnly(bottom: 150);
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
            title,
            subtitle,
            const Expanded(child: SizedBox()),
            cameraView,
            const Expanded(child: SizedBox()),
            licenseText,
            takePhotoButton,
          ],
        ).paddingSymmetric(horizontal: 20),
      ),
    );
  }

  TextStyle _messageStyle({required bool underline, double opacity = 1}) {
    return TextStyle(
      color: Colors.white.withOpacity(opacity),
      fontWeight: FontWeightCompat.medium,
      fontSize: 11,
      decoration: underline ? TextDecoration.underline : TextDecoration.none,
    );
  }
}
