// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/app/modules/projects_management/controllers/projects_management_controller.dart';
import 'package:blockie_app/app/modules/projects_management/models/project.dart';
import 'package:blockie_app/app/modules/projects_management/models/projects.dart';
import 'package:blockie_app/app/modules/projects_management/models/projects_type.dart';
import 'package:blockie_app/app/modules/projects_management/views/projects_management_activity_view.dart';
import 'package:blockie_app/models/app_theme_data.dart';
import 'package:blockie_app/widgets/basic_app_bar.dart';
import 'package:blockie_app/widgets/loading_indicator.dart';

class ProjectsManagementContainerView
    extends GetView<ProjectsManagementController> {
  const ProjectsManagementContainerView({super.key});

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
            return _ProjectsManagementView(
              projectsList: projectsValue.projectsList,
              onTap: controller.goToProjectManagement,
            );
          }
        }(),
      ),
    );
  }
}

class _ProjectsManagementView extends StatelessWidget {
  final List<Projects> projectsList;
  final Function(String, List<Project>) onTap;

  const _ProjectsManagementView({
    required this.projectsList,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: projectsList.length,
      itemBuilder: (_, index) {
        final projects = projectsList[index];
        switch (projects.type) {
          case ProjectsType.project:
            return Text('');
          case ProjectsType.activity:
            return ProjectsManagementActivityView(
              projects: projectsList[index],
              onTap: () =>
                  onTap(projectsList[index].name, projectsList[index].projects),
              issuerOnTap: () {},
              showsIssuer: false,
            );
        }
      },
    );
  }
}
