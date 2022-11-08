// Flutter imports:
import 'package:blockie_app/models/app_theme_data.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/app/modules/activity/views/activity_step_button.dart';
import 'package:blockie_app/extensions/extensions.dart';
import '../models/activity_step.dart';

class ActivityStepsView extends StatelessWidget {
  final String title;
  final List<ActivityStep> steps;
  final Function(ActivityStep)? onTap;

  const ActivityStepsView({
    super.key,
    required this.title,
    required this.steps,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final stepButton = steps
        .map(
          (it) => ActivityStepButton(
            title: it.title,
            status: it.status,
            onTap: () => onTap?.call(it),
          ).paddingSymmetric(vertical: 8),
        )
        .toList();
    return Column(
      children: [
        Row(
          children: [
            const Text('未开始')
                .fontSize(10)
                .textColor(const Color(0xB2FFFFFF))
                .paddingSymmetric(horizontal: 7),
            const Spacer(flex: 1),
            const Text('2022-10-27 12：00 ~ 2022-11-07 17：00')
                .fontSize(10)
                .textColor(const Color(0xB2FFFFFF))
                .paddingSymmetric(horizontal: 7),
          ],
        ).paddingSymmetric(vertical: 6),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
                Text(title)
                    .textColor(AppThemeData.secondaryColor)
                    .fontSize(18)
                    .fontWeight(FontWeightCompat.bold)
                    .paddingOnly(bottom: 8)
              ] +
              stepButton,
        ).paddingOnly(top: 11, bottom: 24, left: 10, right: 10).outlined(),
      ],
    ).paddingSymmetric(vertical: 14);
  }
}
