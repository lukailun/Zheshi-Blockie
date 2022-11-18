// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/app/modules/activity/models/subactivity.dart';
import 'package:blockie_app/app/modules/activity/views/subactivity_step_button.dart';
import 'package:blockie_app/extensions/extensions.dart';
import 'package:blockie_app/models/app_theme_data.dart';
import 'package:blockie_app/models/subactivity_step.dart';

class SubactivityStepsView extends StatelessWidget {
  final Subactivity subactivity;
  final Function(SubactivityStep)? stepOnTap;
  final Function()? contactUsOnTap;

  const SubactivityStepsView({
    super.key,
    required this.subactivity,
    this.stepOnTap,
    this.contactUsOnTap,
  });

  @override
  Widget build(BuildContext context) {
    final stepButtons = subactivity.steps
        .map(
          (it) => SubactivityStepButton(
            title: it.title,
            iconUrl: it.iconUrl,
            isCompleted: it.isCompleted,
            isEnabled: !it.isCompleted,
            onTap: () => stepOnTap?.call(it),
          ).paddingSymmetric(vertical: 8),
        )
        .toList();
    final children = [
          Text(subactivity.steps.first.category)
              .textColor(AppThemeData.secondaryColor)
              .fontSize(18)
              .fontWeight(FontWeightCompat.bold)
              .paddingOnly(bottom: 8)
        ] +
        stepButtons;
    if (subactivity.staffQrCodeUrl != null) {
      children.add(
        SizedBox(
          width: double.infinity,
          child: GestureDetector(
            onTap: contactUsOnTap,
            behavior: HitTestBehavior.translucent,
            child: const Text('有问题请联系客服')
                .textColor(const Color(0x80FFFFFF))
                .fontSize(12)
                .withUnderLine()
                .textAlignment(TextAlign.center)
                .paddingSymmetric(horizontal: 20, vertical: 5),
          ),
        ),
      );
    }
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(subactivity.status.description)
                .fontSize(10)
                .textColor(Color(subactivity.status.colorValue))
                .paddingSymmetric(horizontal: 7),
            const Spacer(flex: 1),
            Text('${subactivity.startedTime ?? ''} ~ ${subactivity.endedTime ?? ''}')
                .fontSize(10)
                .textColor(Color(subactivity.status.colorValue))
                .paddingSymmetric(horizontal: 7),
          ],
        ).paddingSymmetric(vertical: 6),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: children,
        ).paddingOnly(top: 11, bottom: 24, left: 10, right: 10).outlined(),
      ],
    ).paddingSymmetric(vertical: 14);
  }
}
