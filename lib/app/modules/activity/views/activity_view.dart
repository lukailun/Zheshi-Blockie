// Dart imports:
import 'dart:html' as html;
import 'dart:ui' as ui;

// Flutter imports:
import 'package:blockie_app/app/modules/activity/views/activity_benefits_view.dart';
import 'package:blockie_app/app/modules/activity/views/activity_description_view.dart';
import 'package:blockie_app/app/modules/activity/views/activity_participants_view.dart';
import 'package:blockie_app/app/modules/activity/views/activity_steps_view.dart';
import 'package:blockie_app/models/app_theme_data.dart';
import 'package:blockie_app/services/auth_service.dart';
import 'package:blockie_app/widgets/segmented_control/segmented_control.dart';
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
import 'package:blockie_app/models/environment.dart';
import 'package:blockie_app/widgets/basic_app_bar.dart';
import 'package:blockie_app/widgets/loading_indicator.dart';

class ActivityContainerView extends GetView<ActivityController> {
  const ActivityContainerView({super.key});

  @override
  Widget build(BuildContext context) {
    final showsBack = Get.routing.previous.isNotEmpty;
    return Obx(
      () => Scaffold(
        backgroundColor: Colors.transparent,
        appBar: BasicAppBar(
          showsLogo: !showsBack,
        ),
        body: () {
          final activityValue = controller.activity.value;
          if (activityValue == null) {
            return const LoadingIndicator();
          } else {
            return _ActivityView(
              activity: activityValue,
              controller: controller,
              issuerOnTap: controller.goToBrand,
              stepOnTap: (step) {
                switch (step.actionInfo.action) {
                  case ActivityAction.login:
                    if (step.status == ActivityStepStatus.toDo) {
                      controller.showLicenseDialog();
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

  final ActivityController controller;
  final Function(String)? issuerOnTap;
  final Function(ActivityStep)? stepOnTap;

  const _ActivityView({
    required this.activity,
    required this.controller,
    this.issuerOnTap,
    this.stepOnTap,
  });

  @override
  Widget build(BuildContext context) {
    final title = SizedBox(
      width: double.infinity,
      child: Text(
        activity.name.formatted,
        maxLines: 100,
      )
          .fontSize(32)
          .fontWeight(FontWeightCompat.regular)
          .textColor(Colors.white),
    ).paddingSymmetric(horizontal: 22);
    final issuer = GestureDetector(
      onTap: () => issuerOnTap?.call(activity.issuer.id),
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
          Flexible(
            child: Text(
              activity.issuer.name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            )
                .textColor(Colors.white)
                .fontWeight(FontWeightCompat.regular)
                .fontSize(14)
                .paddingSymmetric(horizontal: 10),
          ),
        ],
      ),
    ).paddingSymmetric(horizontal: 22, vertical: 16);

    final tabBar = Theme(
      data: ThemeData(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      child: TabBar(
        controller: controller.tabController,
        indicatorSize: TabBarIndicatorSize.label,
        indicatorPadding: const EdgeInsets.symmetric(vertical: 10),
        indicator: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: AppThemeData.secondaryColor),
        labelColor: AppThemeData.primaryColor,
        unselectedLabelColor: Colors.white,
        tabs: controller.segmentedControlItems
            .asMap()
            .entries
            .map(
              (it) => Tab(
                child: Text(it.value.title)
                    .fontSize(17)
                    .paddingSymmetric(horizontal: 10),
              ),
            )
            .toList(),
      ),
    );
    final divider = Container(
      height: 2,
      decoration: const BoxDecoration(
        color: Colors.black,
        shape: BoxShape.rectangle,
        boxShadow: [
          BoxShadow(
            color: Color(0x4DFFFFFF),
            spreadRadius: 0,
            blurRadius: 2,
            offset: Offset(-2, 1),
          ),
          BoxShadow(
            color: Colors.black,
            spreadRadius: 0,
            blurRadius: 8,
            offset: Offset(-1, -1),
          ),
        ],
      ),
    );
    final stepViews = ActivityStepsView(
      title: '步骤',
      steps: activity.steps,
      onTap: stepOnTap,
    );
    final benefitView = ActivityBenefitsView(
      title: '权益',
      step: activity.steps.first,
    );
    final descriptionView = ActivityDescriptionView(
      title: '简介',
      description:
          '众号推文/现场物料扫码跳转活动页，注册登录“数字钱包”，即可领取限时限量的“球迷身份数字凭证盲盒”，根据抽取的不同主题凭证可在赛事现场兑换各赞助方准备的权益和福利' +
              '2022上冠联赛SHCL篮球让生活更快乐！2022上冠联赛邀请您进入“运动元宇宙”为您带来参与赛事的全流程的新体验，打造您的“篮球数字资产”' +
              '上海市篮球冠军联赛（简称“上冠联赛SHCL”）是一项由上海市篮球协会创立主办的业余成人五人制和三人制篮球品牌赛事。赛事每年举办一届，'
                  '设立全市16个区海选赛，覆盖18至45周岁的篮球运动爱好者。'
                  '市篮协以“打造全市最高等级业余篮球赛事，创立全新篮球”为初衷；以“篮球让生活更快乐”为发展愿景，'
                  '目标将上冠联赛打造成为上海群众篮球活动的第一品牌，持续挖掘城市篮球底蕴，带动上海篮球氛围。',
    );
    final participantsView = ActivityParticipantsView(
      title: '参与者',
      avatarUrls: [AuthService.to.user.value?.avatarUrl ?? ''],
    );
    final tabBarView = TabBarView(
      controller: controller.tabController,
      children: controller.segmentedControlItems.map((it) {
        return SingleChildScrollView(
          child: Column(
            children: [
              stepViews,
              benefitView,
              descriptionView,
              participantsView,
              const Text(
                      '本平台发行的各种NFT是由 Conflux 树图提供区块链底层技术支持，在 Conflux 树图链上有唯一映射虚拟凭证的数字资产。'
                      '每个NFT都具有不可拆分、不可替代、独一无二的特点，并具有可追溯的稀缺性。它虽然没有任何的支付等货币属性，却承载着对你独特唯一的体验与收藏价值。'
                      '所有NFT创造者信息、内容信息和交易记录都将被完整、永久记录在区块链上，任何人都无法随意篡改，全生命周期可追溯，并提供多种认证服务。')
                  .textColor(const Color(0xFFCCCCCC))
                  .fontSize(10)
                  .paddingOnly(bottom: 50),
            ],
          ),
        );
      }).toList(),
    ).paddingSymmetric(horizontal: 22);

    return Column(
      children: [
        title,
        issuer,
        tabBar,
        divider,
        Expanded(child: tabBarView),
      ],
    );
  }
}
