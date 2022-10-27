// Dart imports:
import 'dart:html' as html;
import 'dart:ui' as ui;

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/app/modules/activity/controllers/activity_controller.dart';
import 'package:blockie_app/app/modules/activity/models/activity.dart';
import 'package:blockie_app/app/modules/activity/models/activity_action_info.dart';
import 'package:blockie_app/app/modules/activity/models/activity_step.dart';
import 'package:blockie_app/app/modules/activity/views/activity_step_view.dart';
import 'package:blockie_app/extensions/extensions.dart';
import 'package:blockie_app/models/app_bar_button_item.dart';
import 'package:blockie_app/services/anyweb_service.dart';
import 'package:blockie_app/widgets/basic_app_bar.dart';
import 'package:blockie_app/widgets/loading_indicator.dart';

class ActivityContainerView extends GetView<ActivityController> {
  const ActivityContainerView({super.key});

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
    return Obx(
      () => Scaffold(
        backgroundColor: Colors.transparent,
        appBar: !controller.showsLogin.value
            ? BasicAppBar(
                showsLogo: true,
                actionItems: actionItems,
              )
            : null,
        body: () {
          final activityValue = controller.activity.value;
          if (controller.showsLogin.value) {
            return loginView;
          }
          if (activityValue == null) {
            return const LoadingIndicator();
          } else {
            return _ActivityView(
              activity: activityValue,
              issuerOnTap: controller.goToBrand,
              stepOnTap: (step) {
                switch (step.actionInfo.action) {
                  case ActivityAction.login:
                    if (step.status == ActivityStepStatus.toDo) {
                      controller.prepareToLogin();
                    }
                    break;
                  case ActivityAction.signUp:
                    controller.goToRegistrationInfo(activityValue.id);
                    break;
                  case ActivityAction.mint:
                    final id = step.actionInfo.id;
                    if (id == null) return;
                    controller.goToProjectDetails(id);
                    break;
                }
              },
            );
          }
        }(),
      ),
    );
  }
}

class _ActivityView extends StatelessWidget {
  final Activity activity;
  final Function(String) issuerOnTap;
  final Function(ActivityStep) stepOnTap;

  const _ActivityView({
    required this.activity,
    required this.issuerOnTap,
    required this.stepOnTap,
  });

  @override
  Widget build(BuildContext context) {
    final title = SizedBox(
      width: double.infinity,
      child: Text(activity.name.formatted)
          .fontSize(32)
          .fontWeight(FontWeightCompat.regular)
          .textColor(Colors.white),
    );
    final issuer = GestureDetector(
      onTap: () => issuerOnTap(activity.issuer.id),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: CachedNetworkImage(
              imageUrl: activity.issuer.avatarUrl,
              width: 32,
              height: 32,
              fit: BoxFit.cover,
            ),
          ),
          Text(activity.issuer.name)
              .textColor(Colors.white)
              .fontWeight(FontWeightCompat.regular)
              .fontSize(14)
              .paddingSymmetric(horizontal: 10),
        ],
      ),
    ).paddingSymmetric(vertical: 16);
    final description = SizedBox(
      width: double.infinity,
      child: Text(activity.description.formatted)
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
    ).paddingSymmetric(vertical: 30);
    final List<Widget> header = [title, issuer, description, ruleTitle];
    final List<Widget> stepViews = activity.steps.asMap().entries.map((it) {
      final index = it.key;
      final step = it.value;
      return ActivityStepView(
        index: index + 1,
        step: step,
        onTap: () => stepOnTap(step),
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
