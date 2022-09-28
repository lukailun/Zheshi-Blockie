import 'dart:math';
import 'dart:typed_data';

import 'package:blockie_app/app/modules/face_verification/views/face_verification_camera_view.dart';
import 'package:blockie_app/extensions/extensions.dart';
import 'package:blockie_app/widgets/basic_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:blockie_app/app/modules/face_verification/controllers/face_verification_controller.dart';

import '../../../../models/app_theme_data.dart';
import '../../../../widgets/basic_app_bar.dart';
import '../../../../widgets/screen_bound.dart';

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
            controller.uploadFacePhoto();
            // controller.bytes.value = await file.readAsBytes();
          },
        ),
      ),
    );
    final takePhotoButton = SizedBox(
      height: 48,
      child: BasicElevatedButton(
        borderRadius: 8,
        backgroundColor: Colors.white,
        textColor: AppThemeData.primaryColor,
        title: "同意并拍摄上传",
        onTap: () => _faceVerificationCameraViewKey.currentState?.takePhoto(),
      ),
    ).paddingOnly(bottom: 150);
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
              title,
              subtitle,
              const Expanded(child: SizedBox()),
              cameraView,
              const Expanded(child: SizedBox()),
              Center(
                child: Obx(
                  () => Image.memory(
                    controller.bytes.value ?? Uint8List.fromList([]),
                    width: 100,
                    height: 100,
                  ),
                ),
              ),
              takePhotoButton,
            ],
          ).paddingSymmetric(horizontal: 20),
        ),
      ),
    );
  }
}
