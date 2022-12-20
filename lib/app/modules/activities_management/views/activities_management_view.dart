// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/app/modules/activities_management/controllers/activities_management_controller.dart';
import 'package:blockie_app/app/modules/activities_management/models/activity.dart';
import 'package:blockie_app/app/modules/activities_management/models/activity_type.dart';
import 'package:blockie_app/app/modules/activities_management/models/subactivity.dart';
import 'package:blockie_app/app/modules/activities_management/views/activity_item_view.dart';
import 'package:blockie_app/app/modules/activities_management/views/subactivity_item_view.dart';
import 'package:blockie_app/data/models/app_theme_data.dart';
import 'package:blockie_app/widgets/basic_app_bar.dart';
import 'package:blockie_app/widgets/loading_indicator.dart';

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
              subactivitiesOnTap: controller.goToProjectsManagement,
              activitiesOnTap: controller.goToSubactivitiesManagement,
            );
          }
        }(),
      ),
    );
  }
}

class _ActivitiesManagementView extends StatelessWidget {
  final List<Activity> activities;
  final Function(String, Subactivity)? subactivitiesOnTap;
  final Function(String, List<Subactivity>)? activitiesOnTap;

  const _ActivitiesManagementView({
    required this.activities,
    this.subactivitiesOnTap,
    this.activitiesOnTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: activities.length,
      padding: const EdgeInsets.symmetric(horizontal: 22),
      itemBuilder: (_, index) {
        final activity = activities[index];
        switch (activity.type) {
          case ActivityType.activity:
            return ActivityItemView(
              activity: activities[index],
              issuer: activities[index].issuer,
              onTap: () => activitiesOnTap?.call(
                  activities[index].name, activities[index].subactivities),
            );
          case ActivityType.subactivity:
            return SubactivityItemView(
              subactivity: activities[index].subactivities.first,
              issuer: activities[index].issuer,
              onTap: () => subactivitiesOnTap?.call(activities[index].name,
                  activities[index].subactivities.first),
            );
        }
      },
    );
  }
}
