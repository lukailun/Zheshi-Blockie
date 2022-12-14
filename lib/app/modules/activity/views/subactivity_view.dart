// Flutter imports:
import 'package:blockie_app/app/modules/activity/views/subactivity_info_view.dart';
import 'package:blockie_app/utils/clipboard_utils.dart';
import 'package:blockie_app/widgets/message_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/app/modules/activity/controllers/subactivity_controller.dart';
import 'package:blockie_app/app/modules/activity/views/subactivity_description_view.dart';
import 'package:blockie_app/app/modules/activity/views/subactivity_participants_view.dart';
import 'package:blockie_app/app/modules/activity/views/subactivity_projects_view.dart';
import 'package:blockie_app/app/modules/activity/views/subactivity_steps_view.dart';
import 'package:blockie_app/extensions/extensions.dart';
import 'package:blockie_app/widgets/keep_alive_wrapper.dart';
import 'package:blockie_app/widgets/loading_indicator.dart';

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
            stepOnTap: (step) => controller.handleStepTap(subactivity, step),
            contactUsOnTap: controller.openStaffQrCodeDialog,
          ),
        );
        final projectsView = Visibility(
          visible: subactivity.projects.isNotEmpty,
          child: SubactivityProjectsView(
            subactivity: subactivity,
            mintStatuses: controller.mintStatuses.value,
            detailsOnTap: controller.goToProjectDetails,
            mintOnTap: controller.prepareToMint,
          ),
        );
        final infoView = Visibility(
          visible: true,
          child: SubactivityInfoView(
            title: '????????????',
            onLocationTap: controller.openLocation,
            onPhoneTap: controller.makePhoneCall,
            onWechatTap: () {
              final copySuccess = ClipboardUtils.copyToClipboard('123');
              MessageToast.showMessage(copySuccess ? '????????????' : '????????????');
            },
          ),
        );
        final descriptionView = Visibility(
          visible: subactivity.description.isNotEmpty,
          child: SubactivityDescriptionView(
            title: '??????',
            description: subactivity.description,
          ),
        );
        final participantsView = Visibility(
          visible: subactivity.participantAvatarUrls.isNotEmpty,
          child: SubactivityParticipantsView(
            title: '?????????',
            numberOfParticipants: subactivity.numberOfParticipants,
            avatarUrls: subactivity.participantAvatarUrls,
          ),
        );
        return KeepAliveWrapper(
          keepAlive: true,
          child: NotificationListener<ScrollNotification>(
            onNotification: (notification) {
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
                  infoView,
                  descriptionView,
                  participantsView,
                  const Text(
                    '???????????????????????? NFT ?????? Conflux ????????????????????????????????????????????? Conflux ?????????????????????????????????????????????????????????'
                    '?????? NFT ????????????????????????????????????????????????????????????????????????????????????????????????'
                    '?????????????????????????????????????????????????????????????????????????????????????????????????????????'
                    '?????? NFT ???????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????',
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
