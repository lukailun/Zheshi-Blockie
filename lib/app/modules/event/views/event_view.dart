import 'package:blockie_app/app/modules/event/models/event.dart';
import 'package:blockie_app/app/modules/event/models/event_action_info.dart';
import 'package:blockie_app/app/modules/event/models/event_step.dart';
import 'package:blockie_app/app/modules/event/views/event_step_view.dart';
import 'package:blockie_app/extensions/extensions.dart';
import 'package:blockie_app/models/app_bar_button_item.dart';
import 'package:blockie_app/services/anyweb_service.dart';
import 'package:blockie_app/widgets/loading_indicator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:blockie_app/app/modules/event/controllers/event_controller.dart';
import 'dart:html' as html;
import 'dart:ui' as ui;
import '../../../../widgets/basic_app_bar.dart';
import '../../../../widgets/screen_bound.dart';

class EventContainerView extends GetView<EventController> {
  const EventContainerView({super.key});

  @override
  Widget build(BuildContext context) {
    //ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(AnyWebMethod.accounts.value,
        (int viewId) {
      return html.IFrameElement()
        ..style.width = '100%'
        ..style.height = '100%'
        ..src =
            'https://zheshi.tech/public/dist/?method=${AnyWebMethod.accounts.value}'
        ..style.border = 'none';
    });

    final loginView = HtmlElementView(viewType: AnyWebMethod.accounts.value);
    final actionItems = <AppBarButtonItem>[];
    if (Get.routing.previous.isNotEmpty) {
      actionItems.add(
        AppBarButtonItem(
          assetName: "images/app_bar/close.png",
          onTap: () {
            Get.back();
          },
        ),
      );
    }
    return ScreenBoundary(
      padding: 0,
      body: Obx(
        () => Scaffold(
          backgroundColor: Colors.transparent,
          appBar: !controller.showsLogin.value
              ? BasicAppBar(
                  showsLogo: true,
                  actionItems: actionItems,
                )
              : null,
          body: () {
            if (controller.showsLogin.value) {
              return loginView;
            }
            if (controller.event.value == null) {
              return const LoadingIndicator();
            } else {
              final event = controller.event.value!;
              return _EventView(
                event: event,
                onTap: (step) {
                  switch (step.actionInfo.action) {
                    case EventAction.login:
                      if (step.status == EventStepStatus.toDo) {
                        controller.prepareToLogin();
                      }
                      break;
                    case EventAction.signUp:
                      controller.goToRegistrationInfo();
                      break;
                    case EventAction.mint:
                      controller.goToProjectDetails(step.ID);
                      break;
                  }
                },
              );
            }
          }(),
        ),
      ),
    );
  }
}

class _EventView extends StatelessWidget {
  final Event event;
  final Function(EventStep) onTap;

  const _EventView({
    Key? key,
    required this.event,
    required this.onTap,
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
    final issuer = Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: CachedNetworkImage(
            imageUrl: event.issuer.avatarPath.hostAdded,
            width: 32,
            height: 32,
            fit: BoxFit.cover,
          ),
        ),
        Text(event.issuer.name)
            .textColor(Colors.white)
            .fontWeight(FontWeightCompat.regular)
            .fontSize(14)
            .paddingSymmetric(horizontal: 10),
      ],
    ).paddingSymmetric(vertical: 16);
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
    final List<Widget> header = [title, issuer, description, ruleTitle];
    final List<Widget> stepViews = event.steps.asMap().entries.map((it) {
      final index = it.key;
      final step = it.value;
      return EventStepView(
        index: index + 1,
        step: step,
        onTap: () => onTap(step),
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
