import 'dart:math';

import 'package:blockie_app/extensions/extensions.dart';
import 'package:blockie_app/widgets/basic_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/app_theme_data.dart';

class BasicDialog extends StatelessWidget {
  final String title;
  final String message;
  final void Function() onPositiveButtonTap;
  final void Function() onNegativeButtonTap;

  const BasicDialog({
    Key? key,
    required this.title,
    required this.message,
    required this.onPositiveButtonTap,
    required this.onNegativeButtonTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: min(Get.width - 75, 300),
        height: 225,
        decoration: BoxDecoration(
          color: AppThemeData.primaryColor,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Text(title)
                .withoutUnderLine()
                .fontSize(18)
                .textColor(Colors.white)
                .fontWeight(FontWeightCompat.bold)
                .paddingSymmetric(vertical: 20),
            SizedBox(
              height: 70,
              child: Center(
                child: Text(message)
                    .withoutUnderLine()
                    .fontSize(14)
                    .textColor(const Color(0xCCFFFFFF))
                    .fontWeight(FontWeightCompat.medium)
                    .paddingSymmetric(horizontal: 14),
              ),
            ).outlined(),
            Row(
              children: [
                Expanded(
                  child: BasicElevatedButton(
                    title: '取消',
                    backgroundColor: Colors.white,
                    textColor: AppThemeData.primaryColor,
                    borderRadius: 8,
                    onTap: onNegativeButtonTap,
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: BasicElevatedButton(
                    title: '确认',
                    borderRadius: 8,
                    onTap: onPositiveButtonTap,
                  ),
                ),
              ],
            ).paddingOnly(top: 20),
          ],
        ).paddingSymmetric(horizontal: 18),
      ),
    );
  }
}
