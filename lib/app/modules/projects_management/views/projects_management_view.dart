// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/app/modules/projects_management/controllers/projects_management_controller.dart';
import 'package:blockie_app/app/modules/projects_management/views/project_item_view.dart';
import 'package:blockie_app/data/models/app_theme_data.dart';
import 'package:blockie_app/extensions/extensions.dart';
import 'package:blockie_app/widgets/basic_app_bar.dart';
import 'package:blockie_app/widgets/loading_indicator.dart';

class ProjectsManagementView extends GetView<ProjectsManagementController> {
  const ProjectsManagementView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: AppThemeData.primaryColor,
        appBar: BasicAppBar(title: '活动管理'),
        body: () {
          final projectsValue = controller.projects.value;
          if (projectsValue == null) {
            return const LoadingIndicator();
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(controller.name)
                    .textColor(Colors.white)
                    .fontSize(24)
                    .paddingOnly(left: 22, right: 22, bottom: 11),
                Expanded(
                  child: ListView.builder(
                    itemCount: projectsValue.length,
                    padding: const EdgeInsets.symmetric(horizontal: 22),
                    itemBuilder: (_, index) {
                      final project = projectsValue[index];
                      return ProjectItemView(
                        project: project,
                        onTap: () =>
                            controller.openProjectOperationDialog(project),
                      );
                    },
                  ),
                ),
              ],
            );
          }
        }(),
      ),
    );
  }
}
