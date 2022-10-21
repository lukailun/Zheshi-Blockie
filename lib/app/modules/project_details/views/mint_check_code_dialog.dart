// Dart imports:
import 'dart:convert';
import 'dart:math';
import 'dart:ui';

// Flutter imports:
import 'package:blockie_app/widgets/basic_elevated_button.dart';
import 'package:blockie_app/widgets/basic_text_field.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/extensions/extensions.dart';
import 'package:blockie_app/models/app_theme_data.dart';

extension GetDialogExtension on GetInterface {
  void mintCheckCodeDialog({
    required String checkCode,
  }) {
    Get.dialog(
      _MintCheckCodeDialog(
        checkCode: checkCode,
      ),
      barrierColor: AppThemeData.barrierColor,
    );
  }
}

class _MintCheckCodeDialog extends StatelessWidget {
  final String checkCode;

  const _MintCheckCodeDialog({
    Key? key,
    required this.checkCode,
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
              const Text('请输入验证码')
                  .fontSize(18)
                  .textColor(Colors.white)
                  .paddingOnly(bottom: 7),
              BasicTextField(
                onValueChanged: (text) {},
              ).paddingAll(14).outlined().paddingSymmetric(vertical: 8),
              SizedBox(
                width: double.infinity,
                child: const Text('验证码错误')
                    .fontSize(16)
                    .textColor(const Color(0xFFFA5151))
                    .paddingOnly(left: 14),
              ),
              Row(
                children: [
                  Expanded(
                    child: BasicElevatedButton(
                      title: '取消',
                      borderRadius: 8,
                      onTap: () => Get.back(),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: BasicElevatedButton(
                      title: '确认',
                      backgroundColor: Colors.white,
                      textColor: AppThemeData.primaryColor,
                      borderRadius: 8,
                      onTap: () => Get.back(),
                    ),
                  ),
                ],
              ).paddingOnly(top: 20),
            ],
          ).paddingAll(17),
        ),
      ),
    );
  }
}
