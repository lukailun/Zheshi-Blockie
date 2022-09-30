import 'package:blockie_app/app/modules/event/views/event_step_button.dart';
import 'package:blockie_app/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/event_step.dart';

class EventStepView extends StatelessWidget {
  final int index;
  final EventStep step;
  final GestureTapCallback? onTap;

  const EventStepView({
    Key? key,
    required this.index,
    required this.step,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Widget> contents = [];
    contents.add(
      EventStepButton(
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
    final eventStatus = step.eventStatus;
    if (time.isNotEmpty || eventStatus != ProjectStatus.unknown) {
      contents.add(
        SizedBox(
          width: double.infinity,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                "images/event/time.png",
              ),
              Text(time)
                  .fontSize(16)
                  .fontWeight(FontWeightCompat.regular)
                  .textAlignment(TextAlign.start)
                  .textColor(Colors.white)
                  .paddingSymmetric(horizontal: 10),
              const Expanded(child: SizedBox()),
              Text(eventStatus.description)
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
    if (contents.length == 1) {
      return Column(
        children: contents,
      ).paddingAll(8).paddingSymmetric(vertical: 20);
    } else {
      return Column(
        children: contents,
      ).outlined().paddingSymmetric(vertical: 15);
    }
  }
}
