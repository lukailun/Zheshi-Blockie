// Dart imports:
import 'dart:math';
import 'dart:ui';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/data/models/app_theme_data.dart';
import 'package:blockie_app/extensions/extensions.dart';
import 'package:blockie_app/widgets/basic_elevated_button.dart';
import 'package:blockie_app/widgets/blur.dart';

enum ButtonArrangementDirection {
  horizontal,
  vertical,
}

extension GetDialogExtension on GetInterface {
  void twoButtonDialog({
    required String title,
    required String message,
    required String positiveButtonTitle,
    required Function() positiveButtonOnTap,
    required String negativeButtonTitle,
    required Function() negativeButtonOnTap,
    ButtonArrangementDirection direction =
        ButtonArrangementDirection.horizontal,
  }) {
    Get.dialog(
      BasicTwoButtonDialog(
        title: title,
        message: message,
        positiveButtonTitle: positiveButtonTitle,
        positiveButtonOnTap: positiveButtonOnTap,
        negativeButtonTitle: negativeButtonTitle,
        negativeButtonOnTap: negativeButtonOnTap,
        direction: direction,
      ),
      barrierColor: AppThemeData.barrierColor,
    );
  }
}

class BasicTwoButtonDialog extends StatelessWidget {
  final String title;
  final String message;
  final String positiveButtonTitle;
  final Function() positiveButtonOnTap;
  final String negativeButtonTitle;
  final Function() negativeButtonOnTap;
  final ButtonArrangementDirection direction;

  const BasicTwoButtonDialog({
    super.key,
    required this.title,
    required this.message,
    required this.positiveButtonTitle,
    required this.positiveButtonOnTap,
    required this.negativeButtonTitle,
    required this.negativeButtonOnTap,
    this.direction = ButtonArrangementDirection.horizontal,
  });

  @override
  Widget build(BuildContext context) {
    return Blur(
      blurOnTap: Get.back,
      child: Center(
        child: Container(
          decoration: const BoxDecoration(
            color: AppThemeData.primaryColor,
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
          ),
          width: min(Get.width - 75, 300),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(title)
                  .textColor(Colors.white)
                  .fontSize(18)
                  .paddingSymmetric(vertical: 10),
              Center(
                child: Text(
                  message,
                  textAlign: TextAlign.center,
                  maxLines: 100,
                )
                    .textColor(const Color(0xCCFFFFFF))
                    .fontSize(16)
                    .paddingSymmetric(horizontal: 14, vertical: 19),
              ).outlined(),
              (direction == ButtonArrangementDirection.horizontal
                      ? Row(
                          children: [
                            Expanded(
                              child: BasicElevatedButton(
                                title: negativeButtonTitle,
                                borderRadius: 8,
                                onTap: negativeButtonOnTap,
                              ),
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: BasicElevatedButton(
                                title: positiveButtonTitle,
                                backgroundColor: Colors.white,
                                textColor: AppThemeData.primaryColor,
                                borderRadius: 8,
                                onTap: positiveButtonOnTap,
                              ),
                            ),
                          ],
                        )
                      : Column(
                          children: [
                            BasicElevatedButton(
                              title: positiveButtonTitle,
                              backgroundColor: Colors.white,
                              textColor: AppThemeData.primaryColor,
                              borderRadius: 8,
                              onTap: positiveButtonOnTap,
                            ),
                            const SizedBox(height: 14),
                            BasicElevatedButton(
                              title: negativeButtonTitle,
                              borderRadius: 8,
                              onTap: negativeButtonOnTap,
                            ),
                          ],
                        ))
                  .paddingOnly(top: 23, bottom: 28),
            ],
          ).paddingSymmetric(horizontal: 17),
        ),
      ),
    );
  }
}
