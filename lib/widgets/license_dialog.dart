// Dart imports:
import 'dart:math';

// Flutter imports:
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/extensions/extensions.dart';
import 'package:blockie_app/widgets/basic_elevated_button.dart';
import '../models/app_theme_data.dart';

class LicenseDialog extends StatelessWidget {
  final void Function() onTermsOfServiceTap;
  final void Function() onPrivacyPolicyTap;
  final void Function() onPositiveButtonTap;
  final void Function() onNegativeButtonTap;

  const LicenseDialog({
    Key? key,
    required this.onTermsOfServiceTap,
    required this.onPrivacyPolicyTap,
    required this.onPositiveButtonTap,
    required this.onNegativeButtonTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: min(Get.width - 75, 300),
        height: 255,
        decoration: BoxDecoration(
          color: AppThemeData.primaryColor,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            const Text('用户协议及隐私政策')
                .withoutUnderLine()
                .fontSize(18)
                .textColor(Colors.white)
                .fontWeight(FontWeightCompat.bold)
                .paddingSymmetric(vertical: 20),
            SizedBox(
              height: 70,
              child: Center(
                child: RichText(
                  text: TextSpan(children: [
                    TextSpan(
                      text: '为了保障您的合法权益，请阅读并同意',
                      style: _messageStyle(underline: false),
                    ),
                    TextSpan(
                        text: '用户条款',
                        style: _messageStyle(underline: true),
                        recognizer: TapGestureRecognizer()
                          ..onTap = onTermsOfServiceTap),
                    TextSpan(
                      text: '和',
                      style: _messageStyle(underline: false),
                    ),
                    TextSpan(
                        text: '隐私政策',
                        style: _messageStyle(underline: true),
                        recognizer: TapGestureRecognizer()
                          ..onTap = onPrivacyPolicyTap),
                  ]),
                ).paddingSymmetric(horizontal: 14),
              ),
            ).outlined(),
            BasicElevatedButton(
              title: '同意并注册/登录',
              backgroundColor: Colors.white,
              textColor: AppThemeData.primaryColor,
              borderRadius: 8,
              onTap: onPositiveButtonTap,
            ).paddingOnly(top: 18),
            BasicElevatedButton(
              title: '不同意',
              showsBorder: false,
              showsShadow: false,
              backgroundColor: Colors.transparent,
              textColor: const Color(0x80FFFFFF),
              borderRadius: 8,
              onTap: onNegativeButtonTap,
            ).paddingOnly(top: 8),
          ],
        ).paddingSymmetric(horizontal: 18),
      ),
    );
  }

  TextStyle _messageStyle({required bool underline}) {
    return TextStyle(
      color: Colors.white,
      fontWeight: FontWeightCompat.medium,
      fontSize: 14,
      decoration: underline ? TextDecoration.underline : TextDecoration.none,
    );
  }
}
