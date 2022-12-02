// Dart imports:
import 'dart:convert';
import 'dart:math';
import 'dart:ui';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/data/models/app_theme_data.dart';
import 'package:blockie_app/data/models/user_info.dart';
import 'package:blockie_app/extensions/extensions.dart';
import 'package:blockie_app/widgets/blur.dart';

extension GetDialogExtension on GetInterface {
  void qrCodeDialog({
    required UserInfo user,
    required String qrCode,
    Function()? onClosed,
  }) {
    Get.dialog(
      QrCodeDialog(
        user: user,
        qrCode: qrCode,
        onClosed: onClosed,
      ),
      barrierColor: AppThemeData.barrierColor,
      barrierDismissible: false,
    );
  }
}

class QrCodeDialog extends StatelessWidget {
  final UserInfo user;
  final String qrCode;
  final Function()? onClosed;

  const QrCodeDialog({
    Key? key,
    required this.user,
    required this.qrCode,
    this.onClosed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Blur(
      blur: 5,
      blurColor: const Color(0x10FFFFFF),
      colorOpacity: 0.05,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          GestureDetector(
            onTap: () {
              Get.back();
              onClosed?.call();
            },
            child: Image.asset(
              "assets/images/app_bar/close.png",
              width: 34,
              height: 34,
            ),
          ).paddingOnly(top: 22, right: 22),
          const Spacer(flex: 1),
          Center(
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
                  SizedBox(
                    width: 72,
                    height: 72,
                    child: CircleAvatar(
                      radius: 36,
                      backgroundImage: NetworkImage(user.avatarUrl),
                    ),
                  ).paddingOnly(bottom: 7),
                  Text(user.username).fontSize(18).textColor(Colors.white),
                  AspectRatio(
                    aspectRatio: 1,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      child: Image.memory(
                        base64Decode(qrCode),
                        fit: BoxFit.cover,
                      ).paddingAll(8),
                    ),
                  ).paddingSymmetric(horizontal: 8, vertical: 25),
                  Image.asset(
                    'assets/images/app_bar/logo.png',
                    width: 151,
                    height: 25,
                    fit: BoxFit.contain,
                  ),
                ],
              ).paddingAll(17),
            ),
          ),
          const Spacer(flex: 1),
        ],
      ),
    );
  }
}
