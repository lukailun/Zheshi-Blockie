import 'package:blockie_app/app/modules/activity/controllers/subactivity_controller.dart';
import 'package:blockie_app/app/modules/activity/views/subactivity_projects_view.dart';
import 'package:blockie_app/app/modules/activity/views/subactivity_description_view.dart';
import 'package:blockie_app/app/modules/activity/views/subactivity_participants_view.dart';
import 'package:blockie_app/app/modules/activity/views/subactivity_steps_view.dart';
import 'package:blockie_app/extensions/extensions.dart';
import 'package:blockie_app/widgets/keep_alive_wrapper.dart';
import 'package:blockie_app/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

class SubactivityView extends GetView<SubactivityController> {
  final scrollController = ScrollController();
  final String id;
  final bool headerIsExpanded;
  final Function(bool)? headerShouldExpandCallback;

  SubactivityView({
    super.key,
    required this.id,
    this.headerIsExpanded = true,
    this.headerShouldExpandCallback,
  });

  @override
  String? get tag => id;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        final subactivity = controller.subactivity.value;
        if (subactivity == null) {
          return const LoadingIndicator();
        }
        final stepViews = Visibility(
          visible: subactivity.steps.isNotEmpty,
          child: SubactivityStepsView(
            subactivity: subactivity,
            stepOnTap: controller.handleStepTap,
            contactUsOnTap: controller.openStaffQrCodeDialog,
          ),
        );
        final projectsView = Visibility(
          visible: subactivity.projects.isNotEmpty,
          child: SubactivityProjectsView(
            projects: subactivity.projects,
            mintStatuses: controller.mintStatuses.value,
            detailsOnTap: controller.goToProjectDetails,
            previewOnTap: controller.goToPreviewVideo,
            mintOnTap: controller.prepareToMint,
            isScrolling: controller.isScrolling.value,
          ),
        );
        final descriptionView = Visibility(
          visible: subactivity.description.isNotEmpty,
          child: SubactivityDescriptionView(
            title: '简介',
            description: subactivity.description,
          ),
        );
        final participantsView = Visibility(
          visible: subactivity.participantAvatarUrls.isNotEmpty,
          child: SubactivityParticipantsView(
            title: '参与者',
            avatarUrls: subactivity.participantAvatarUrls,
          ),
        );
        return KeepAliveWrapper(
          keepAlive: true,
          child: NotificationListener<ScrollNotification>(
            onNotification: (notification) {
              if (notification is ScrollStartNotification) {
                controller.isScrolling.value = true;
              } else if (notification is ScrollEndNotification) {
                controller.isScrolling.value = false;
              }
              final offset = notification.metrics.pixels;
              final isScrollForward =
                  scrollController.position.userScrollDirection ==
                      ScrollDirection.forward;
              if (notification is! ScrollStartNotification) {
                const headerExpandThreshold = 1.0;
                if (headerIsExpanded) {
                  if (offset > headerExpandThreshold && !isScrollForward) {
                    headerShouldExpandCallback?.call(false);
                  }
                } else {
                  if (offset < headerExpandThreshold && isScrollForward) {
                    headerShouldExpandCallback?.call(true);
                  }
                }
              }
              return false;
            },
            child: SingleChildScrollView(
              controller: scrollController,
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: Column(
                children: [
                  stepViews,
                  projectsView,
                  descriptionView,
                  participantsView,
                  const Text(
                    '本平台发行的各种 NFT 是由 Conflux 树图提供区块链底层技术支持，在 Conflux 树图链上有唯一映射虚拟凭证的数字资产。'
                    '每个 NFT 都具有不可拆分、不可替代、独一无二的特点，并具有可追溯的稀缺性。'
                    '它虽然没有任何的支付等货币属性，却承载着对你独特唯一的体验与收藏价值。'
                    '所有 NFT 创造者信息、内容信息和交易记录都将被完整、永久记录在区块链上，任何人都无法随意篡改，全生命周期可追溯，并提供多种认证服务。',
                  )
                      .textColor(const Color(0xFFCCCCCC))
                      .fontSize(10)
                      .paddingOnly(top: 10, bottom: 50),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
