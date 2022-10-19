// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/app/modules/activity/views/activity_step_button.dart';
import 'package:blockie_app/extensions/extensions.dart';
import '../models/activity_step.dart';

class ActivityStepView extends StatelessWidget {
  final int index;
  final ActivityStep step;
  final GestureTapCallback? onTap;

  const ActivityStepView({
    Key? key,
    required this.index,
    required this.step,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Widget> contents = [];
    contents.add(
      ActivityStepButton(
        index: index,
        title: step.title,
        status: step.status,
        onTap: onTap,
      ),
    );
    final description = step.description ?? "";
    if (description.isNotEmpty) {
      contents.add(
        SizedBox(
          width: double.infinity,
          child: Text(description)
              .fontSize(13)
              .fontWeight(FontWeightCompat.regular)
              .textAlignment(TextAlign.start)
              .textColor(Colors.white),
        ).paddingSymmetric(vertical: 12, horizontal: 12),
      );
    }
    final time = step.time ?? "";
    final activityStatus = step.activityStatus;
    if (time.isNotEmpty || activityStatus != ProjectStatus.unknown) {
      contents.add(
        SizedBox(
          width: double.infinity,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                "images/activity/time.png",
                width: 18,
                height: 18,
              ),
              Text(time)
                  .fontSize(16)
                  .fontWeight(FontWeightCompat.regular)
                  .textAlignment(TextAlign.start)
                  .textColor(Colors.white)
                  .paddingSymmetric(horizontal: 10),
              const Expanded(child: SizedBox()),
              Text(activityStatus.description)
                  .fontSize(16)
                  .fontWeight(FontWeightCompat.regular)
                  .textAlignment(TextAlign.end)
                  .textColor(const Color(0xFF07DFAB))
                  .paddingSymmetric(horizontal: 10),
            ],
          ).paddingSymmetric(horizontal: 12),
        ).paddingSymmetric(vertical: 10),
      );
    }
    final imageUrl = step.imageUrl ?? "";
    if (imageUrl.isNotEmpty) {
      contents.add(
        AspectRatio(
          aspectRatio: 1,
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
            ),
          ),
        ),
      );
    }
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.translucent,
      child: () {
        if (contents.length == 1) {
          return Column(
            children: contents,
          ).paddingAll(8).paddingSymmetric(vertical: 20);
        } else {
          return Column(
            children: contents,
          ).outlined().paddingSymmetric(vertical: 15);
        }
      }(),
    );
  }
}
