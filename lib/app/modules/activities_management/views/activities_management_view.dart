// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/app/modules/activities_management/models/activity.dart';
import 'package:blockie_app/app/modules/activities_management/models/activity_type.dart';
import 'package:blockie_app/app/modules/activities_management/models/project.dart';
import 'package:blockie_app/app/modules/activities_management/controllers/activities_management_controller.dart';
import 'package:blockie_app/models/app_theme_data.dart';
import 'package:blockie_app/widgets/basic_app_bar.dart';
import 'package:blockie_app/widgets/loading_indicator.dart';
import 'package:blockie_app/widgets/project_activity_item_view.dart';
import 'package:blockie_app/widgets/project_item_view.dart';

class ActivitiesManagementContainerView
    extends GetView<ActivitiesManagementController> {
  const ActivitiesManagementContainerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: AppThemeData.primaryColor,
        appBar: BasicAppBar(title: '活动管理'),
        body: () {
          final activitiesValue = controller.activities.value;
          if (activitiesValue == null) {
            return const LoadingIndicator();
          } else {
            return _ActivitiesManagementView(
              activities: activitiesValue,
              plainItemOnTap: controller.openProjectOperationDialog,
              groupedItemOnTap: controller.goToProjectsManagement,
            );
          }
        }(),
      ),
    );
  }
}

class _ActivitiesManagementView extends StatelessWidget {
  final List<Activity> activities;
  final Function(Project)? plainItemOnTap;
  final Function(String, List<Project>)? groupedItemOnTap;

  const _ActivitiesManagementView({
    required this.activities,
    this.plainItemOnTap,
    this.groupedItemOnTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: activities.length,
      padding: const EdgeInsets.symmetric(horizontal: 22),
      itemBuilder: (_, index) {
        final activity = activities[index];
        switch (activity.type) {
          case ActivityType.grouped:
            return ProjectActivityItemView(
              activity: activities[index],
              issuer: activities[index].issuer,
              onTap: () => groupedItemOnTap?.call(
                  activities[index].name, activities[index].projects),
            );
          case ActivityType.plain:
            return ProjectItemView(
              project: activities[index].projects.first,
              issuer: activities[index].issuer,
              onTap: () =>
                  plainItemOnTap?.call(activities[index].projects.first),
            );
        }
      },
    );
  }
}
