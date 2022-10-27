// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/app/modules/activity_management/controllers/activity_management_controller.dart';
import 'package:blockie_app/app/modules/projects_management/views/projects_management_project_view.dart';
import 'package:blockie_app/extensions/extensions.dart';
import 'package:blockie_app/models/app_theme_data.dart';
import 'package:blockie_app/widgets/basic_app_bar.dart';

class ActivityManagementView extends GetView<ActivityManagementController> {
  const ActivityManagementView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppThemeData.primaryColor,
      appBar: BasicAppBar(title: '活动管理'),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(controller.name)
              .textColor(Colors.white)
              .fontSize(24)
              .paddingOnly(left: 22, right: 22, bottom: 11),
          Expanded(
            child: ListView.builder(
              itemCount: controller.projects.length,
              padding: const EdgeInsets.symmetric(horizontal: 22),
              itemBuilder: (_, index) {
                final project = controller.projects[index];
                return ProjectsManagementProjectView(
                  project: project,
                  onTap: () => controller.openProjectOperationDialog(project),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
