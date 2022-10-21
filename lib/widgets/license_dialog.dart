// Dart imports:
import 'dart:math';
import 'dart:ui';

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
  final Function() onTermsOfServiceTap;
  final Function() onPrivacyPolicyTap;
  final Function() onPositiveButtonTap;
  final Function() onNegativeButtonTap;

  const LicenseDialog({
    Key? key,
    required this.onTermsOfServiceTap,
    required this.onPrivacyPolicyTap,
    required this.onPositiveButtonTap,
    required this.onNegativeButtonTap,
  }) : super(key: key);

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
              const Text('用户协议及隐私政策')
                  .textColor(Colors.white)
                  .fontSize(18)
                  .paddingSymmetric(vertical: 10),
              Center(
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
                ).paddingSymmetric(horizontal: 14, vertical: 19),
              ).outlined(),
              BasicElevatedButton(
                title: '同意并注册/登录',
                backgroundColor: Colors.white,
                textColor: AppThemeData.primaryColor,
                borderRadius: 8,
                onTap: onPositiveButtonTap,
              ).paddingOnly(top: 23),
              BasicElevatedButton(
                title: '不同意',
                showsBorder: false,
                showsShadow: false,
                backgroundColor: Colors.transparent,
                textColor: const Color(0x80FFFFFF),
                borderRadius: 8,
                onTap: onNegativeButtonTap,
              ).paddingSymmetric(vertical: 10),
            ],
          ).paddingSymmetric(horizontal: 17),
        ),
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
