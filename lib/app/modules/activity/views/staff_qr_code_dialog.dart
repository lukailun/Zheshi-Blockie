// Dart imports:
import 'dart:convert';
import 'dart:html';
import 'dart:math';
import 'dart:ui';

// Flutter imports:
import 'package:blockie_app/widgets/loading_indicator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/extensions/extensions.dart';
import 'package:blockie_app/models/app_theme_data.dart';
import 'package:blockie_app/widgets/html_image.dart';

extension GetDialogExtension on GetInterface {
  void staffQrCodeDialog({
    required String qrCode,
  }) {
    Get.dialog(
      StaffQrCodeDialog(
        qrCode: qrCode,
      ),
      barrierColor: AppThemeData.barrierColor,
      barrierDismissible: false,
    );
  }
}

class StaffQrCodeDialog extends StatelessWidget {
  final String qrCode;
  final imageWidth = 0.obs;
  final imageHeight = 0.obs;

  StaffQrCodeDialog({
    Key? key,
    required this.qrCode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final image = Image(image: CachedNetworkImageProvider(qrCode));
    image.image
        .resolve(const ImageConfiguration())
        .addListener(ImageStreamListener((image, synchronousCall) {
      imageWidth.value = image.image.width;
      imageHeight.value = image.image.height;
    }));
    return Obx(
      () => BackdropFilter(
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
              child: Visibility(
                visible: imageWidth.value * imageHeight.value > 0,
                replacement:
                    const LoadingIndicator(color: AppThemeData.primaryColor),
                child: SizedBox(
                  width: min(Get.width - 75, 300),
                  height: min(Get.width - 75, 300) *
                      imageHeight.value /
                      imageWidth.value,
                  child: HtmlImage(url: qrCode),
                ),
              ),
            ),
            const Spacer(flex: 1),
          ],
        ),
      ),
    );
  }
}
