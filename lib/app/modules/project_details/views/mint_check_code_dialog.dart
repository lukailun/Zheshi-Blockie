// Dart imports:
import 'dart:convert';
import 'dart:math';
import 'dart:ui';

// Flutter imports:
import 'package:blockie_app/widgets/blur.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/extensions/extensions.dart';
import 'package:blockie_app/data/models/app_theme_data.dart';
import 'package:blockie_app/widgets/basic_elevated_button.dart';
import 'package:blockie_app/widgets/basic_text_field.dart';

extension GetDialogExtension on GetInterface {
  void mintCheckCodeDialog({
    required String checkCode,
    required Function() onSuccess,
  }) {
    Get.dialog(
      _MintCheckCodeDialog(
        checkCode: checkCode,
        onSuccess: onSuccess,
      ),
      barrierColor: AppThemeData.barrierColor,
    );
  }
}

class _MintCheckCodeDialog extends StatefulWidget {
  final String checkCode;
  final Function() onSuccess;

  const _MintCheckCodeDialog({
    Key? key,
    required this.checkCode,
    required this.onSuccess,
  }) : super(key: key);

  @override
  State<_MintCheckCodeDialog> createState() => _MintCheckCodeDialogState();
}

class _MintCheckCodeDialogState extends State<_MintCheckCodeDialog> {
  bool _isError = false;
  String _code = '';

  @override
  Widget build(BuildContext context) {
    return Blur(
      blur: 5,
      blurColor: const Color(0x10FFFFFF),
      colorOpacity: 0.05,
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
                text: _code,
                onValueChanged: (text) {
                  _code = text;
                  setState(() => _isError = false);
                },
              ).paddingAll(14).outlined().paddingSymmetric(vertical: 8),
              Opacity(
                opacity: _isError ? 1 : 0,
                child: SizedBox(
                  width: double.infinity,
                  child: const Text('验证码错误')
                      .fontSize(16)
                      .textColor(const Color(0xFFFA5151))
                      .paddingOnly(left: 14),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: BasicElevatedButton(
                      title: '取消',
                      borderRadius: 8,
                      onTap: Get.back,
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
                      onTap: () {
                        if (_code == widget.checkCode) {
                          Get.back();
                          widget.onSuccess();
                        } else {
                          setState(() => _isError = true);
                        }
                      },
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
