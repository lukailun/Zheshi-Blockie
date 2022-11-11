// Dart imports:
import 'dart:ui';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/app/modules/activities_management/models/project.dart';
import 'package:blockie_app/extensions/extensions.dart';
import 'package:blockie_app/models/app_theme_data.dart';
import 'package:blockie_app/widgets/basic_elevated_button.dart';
import 'package:blockie_app/widgets/project_item_view.dart';

extension GetDialogExtension on GetInterface {
  void projectsManagementDialog({
    required Project project,
    required Function() ticketCheckingOnTap,
    required Function() addWhitelistOnTap,
    required Function() airdropNftOnTap,
    required Function() holdVerificationOnTap,
  }) {
    Get.dialog(
      ProjectsManagementDialog(
        project: project,
        ticketCheckingOnTap: ticketCheckingOnTap,
        addWhitelistOnTap: addWhitelistOnTap,
        airdropNftOnTap: airdropNftOnTap,
        holdVerificationOnTap: holdVerificationOnTap,
      ),
      barrierColor: AppThemeData.barrierColor,
    );
  }
}

class ProjectsManagementDialog extends StatelessWidget {
  final Project project;
  final Function() ticketCheckingOnTap;
  final Function() addWhitelistOnTap;
  final Function() airdropNftOnTap;
  final Function() holdVerificationOnTap;

  const ProjectsManagementDialog({
    super.key,
    required this.project,
    required this.ticketCheckingOnTap,
    required this.addWhitelistOnTap,
    required this.airdropNftOnTap,
    required this.holdVerificationOnTap,
  });

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: Center(
        child: Column(
          children: [
            const Spacer(flex: 1),
            ProjectItemView(project: project).paddingSymmetric(horizontal: 22),
            const Spacer(flex: 1),
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
              child: Container(
                width: double.infinity,
                height: 258,
                color: AppThemeData.primaryColor,
                child: Column(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: _ProjectOperationButton(
                              title: '空投 NFT',
                              assetName:
                                  'assets/images/projects_management/airdrop_nft.png',
                              onTap: () {
                                Get.back();
                                airdropNftOnTap();
                              },
                            ),
                          ),
                          Expanded(
                            child: _ProjectOperationButton(
                              title: '验票核销',
                              assetName:
                                  'assets/images/projects_management/ticket_checking.png',
                              onTap: () {
                                Get.back();
                                ticketCheckingOnTap();
                              },
                            ),
                          ),
                          Expanded(
                            child: _ProjectOperationButton(
                              title: '持有验证',
                              assetName:
                                  'assets/images/projects_management/hold_verification.png',
                              onTap: () {
                                Get.back();
                                holdVerificationOnTap();
                              },
                            ),
                          ),
                          Expanded(
                            child: _ProjectOperationButton(
                              title: '加白名单',
                              assetName:
                                  'assets/images/projects_management/add_whitelist.png',
                              onTap: () {
                                Get.back();
                                addWhitelistOnTap();
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    BasicElevatedButton(
                      title: '取消',
                      borderRadius: 8,
                      showsBorder: false,
                      showsShadow: false,
                      textFontSize: 16,
                      onTap: Get.back,
                    ),
                  ],
                ).paddingAll(22),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _ProjectOperationButton extends StatelessWidget {
  final String title;
  final String assetName;
  final Function() onTap;

  const _ProjectOperationButton({
    required this.title,
    required this.assetName,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.translucent,
      child: Column(
        children: [
          Image.asset(
            assetName,
            width: 24,
            height: 24,
          ),
          Text(title).fontSize(14).textColor(Colors.white).paddingOnly(top: 5),
        ],
      ).paddingAll(13),
    );
  }
}
