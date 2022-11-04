// Dart imports:
import 'dart:convert';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/app/modules/activities/models/activity.dart';
import 'package:blockie_app/app/modules/activities/models/project.dart';
import 'package:blockie_app/app/modules/projects_management/controllers/projects_management_controller.dart';
import 'package:blockie_app/app/routes/app_pages.dart';
import 'package:blockie_app/data/repositories/projects_management_repository.dart';

class ActivitiesManagementController extends GetxController {
  final ProjectsManagementRepository repository;

  ActivitiesManagementController({required this.repository});

  final activities = Rxn<List<Activity>>();

  @override
  void onReady() {
    super.onReady();
    _getManagedActivities();
  }

  void _getManagedActivities() async {
    final paginatedActivities = await repository.getManagedActivities();
    activities.value = paginatedActivities?.activities;
  }

  void goToProjectsManagement(
    String name,
    List<Project> projects,
  ) {
    final parameters = {
      ActivitiesManagementParameter.projects: jsonEncode(projects),
      ActivitiesManagementParameter.name: name,
    };
    Get.toNamed(Routes.projectsManagement, parameters: parameters);
  }
}
