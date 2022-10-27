// Dart imports:
import 'dart:ui';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/app/modules/projects_management/models/project.dart';
import 'package:blockie_app/app/modules/projects_management/views/projects_management_project_view.dart';
import 'package:blockie_app/extensions/extensions.dart';
import 'package:blockie_app/models/app_theme_data.dart';
import 'package:blockie_app/widgets/basic_elevated_button.dart';

extension GetDialogExtension on GetInterface {
  void projectOperationDialog({
    required Project project,
    required Function() ticketCheckingOnTap,
  }) {
    Get.dialog(
      ProjectOperationDialog(
        project: project,
        ticketCheckingOnTap: ticketCheckingOnTap,
      ),
      barrierColor: AppThemeData.barrierColor,
    );
  }
}

class ProjectOperationDialog extends StatelessWidget {
  final Project project;
  final Function() ticketCheckingOnTap;

  const ProjectOperationDialog({
    super.key,
    required this.project,
    required this.ticketCheckingOnTap,
  });

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: Center(
        child: Column(
          children: [
            const Spacer(flex: 1),
            ProjectsManagementProjectView(
              project: project,
            ).paddingSymmetric(horizontal: 22),
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
                      child: _ProjectOperationButton(ticketCheckingOnTap: () {
                        Get.back();
                        ticketCheckingOnTap();
                      }),
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
  final Function() ticketCheckingOnTap;

  const _ProjectOperationButton({
    required this.ticketCheckingOnTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ticketCheckingOnTap,
      behavior: HitTestBehavior.translucent,
      child: Column(
        children: [
          Image.asset(
            'images/projects_management/ticket_checking.png',
            width: 24,
            height: 24,
          ),
          const Text('验票核销')
              .fontSize(14)
              .textColor(Colors.white)
              .paddingOnly(top: 5),
        ],
      ).paddingAll(13),
    );
  }
}
