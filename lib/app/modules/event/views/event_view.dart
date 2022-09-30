import 'package:blockie_app/app/modules/event/models/event.dart';
import 'package:blockie_app/app/modules/event/views/event_step_view.dart';
import 'package:blockie_app/app/routes/app_pages.dart';
import 'package:blockie_app/extensions/extensions.dart';
import 'package:blockie_app/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:blockie_app/app/modules/event/controllers/event_controller.dart';

import '../../../../widgets/basic_app_bar.dart';
import '../../../../widgets/screen_bound.dart';

class EventContainerView extends GetView<EventController> {
  const EventContainerView({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenBoundary(
      padding: 0,
      body: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: BasicAppBar(showsLogo: true),
        body: Obx(
          () {
            if (controller.event.value == null) {
              return const LoadingIndicator();
            } else {
              return _EventView(
                event: controller.event.value!,
                onTap: () => controller.goToRegistrationInfo(),
              );
            }
          },
        ),
      ),
    );
  }
}

class _EventView extends StatelessWidget {
  final Event event;
  final GestureTapCallback? onTap;

  const _EventView({
    Key? key,
    required this.event,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final title = SizedBox(
      width: double.infinity,
      child: Text(event.name.formatted)
          .fontSize(32)
          .fontWeight(FontWeightCompat.regular)
          .textColor(Colors.white),
    );
    final description = SizedBox(
      width: double.infinity,
      child: Text(event.description.formatted)
          .fontSize(14)
          .fontWeight(FontWeightCompat.regular)
          .textColor(Colors.white),
    );
    final ruleTitle = SizedBox(
      width: double.infinity,
      child: const Text("赛事限定版 NFT 获取规则")
          .fontSize(20)
          .fontWeight(FontWeightCompat.bold)
          .textAlignment(TextAlign.center)
          .textColor(Colors.white),
    ).paddingSymmetric(vertical: 15);
    final List<Widget> header = [title, description, ruleTitle];
    final List<Widget> stepViews = event.steps.asMap().entries.map((it) {
      final index = it.key;
      final step = it.value;
      return EventStepView(
        index: index + 1,
        step: step,
        onTap: onTap,
      );
    }).toList();
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: header + stepViews,
      ),
    );
  }
}
