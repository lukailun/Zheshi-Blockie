// Dart imports:
import 'dart:math';
import 'dart:ui';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/extensions/extensions.dart';
import 'package:blockie_app/models/app_theme_data.dart';
import 'package:blockie_app/widgets/basic_elevated_button.dart';

class BasicOneButtonDialog extends StatelessWidget {
  final String title;
  final String message;
  final String buttonTitle;
  final VoidCallback buttonOnTap;

  const BasicOneButtonDialog({
    super.key,
    required this.title,
    required this.message,
    required this.buttonTitle,
    required this.buttonOnTap,
  });

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
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
              BasicElevatedButton(
                title: buttonTitle,
                backgroundColor: Colors.white,
                textColor: AppThemeData.primaryColor,
                borderRadius: 8,
                onTap: buttonOnTap,
              ).paddingOnly(top: 23, bottom: 28),
            ],
          ).paddingSymmetric(horizontal: 17),
        ),
      ),
    );
  }
}
