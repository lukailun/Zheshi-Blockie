import 'package:blockie_app/app/modules/face_verification/views/face_verification_camera_view.dart';
import 'package:blockie_app/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:camera/camera.dart';
import 'package:blockie_app/app/modules/face_verification/controllers/face_verification_controller.dart';

import '../../../../models/app_theme_data.dart';
import '../../../../widgets/basic_app_bar.dart';
import '../../../../widgets/screen_bound.dart';

class FaceVerificationView extends GetView<FaceVerificationController> {
  const FaceVerificationView({super.key});

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
    final cameraView = Container(
      width: 200,
      height: 300,
      child: FaceVerificationCameraView(),
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
              title,
              subtitle,
              cameraView,
            ],
          ).paddingSymmetric(horizontal: 20),
        ),
      ),
    );
  }
}
