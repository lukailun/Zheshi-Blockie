// Dart imports:
import 'dart:convert';
import 'dart:math';
import 'dart:ui';

// Flutter imports:
import 'package:blockie_app/widgets/html_image.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/extensions/extensions.dart';
import 'package:blockie_app/models/app_theme_data.dart';

extension GetDialogExtension on GetInterface {
  void staffQrCodeDialog({
    required String qrCode,
  }) {
    Get.dialog(
      StaffQrCodeDialog(
        qrCode: qrCode,
      ),
      barrierColor: AppThemeData.barrierColor,
    );
  }
}

class StaffQrCodeDialog extends StatelessWidget {
  final String qrCode;

  const StaffQrCodeDialog({
    Key? key,
    required this.qrCode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          GestureDetector(
            onTap: () => Get.back(),
            child: Image.asset(
              "assets/images/app_bar/close.png",
              width: 34,
              height: 34,
            ),
          ).paddingOnly(top: 22, right: 22),
          const Spacer(flex: 1),
          Center(
            child: SizedBox(
              width: min(Get.width - 75, 300),
              height: Get.height - 75,
              child: HtmlImage(url: qrCode).paddingAll(17),
            ),
          ),
          const Spacer(flex: 1),
        ],
      ),
    );
  }
}
