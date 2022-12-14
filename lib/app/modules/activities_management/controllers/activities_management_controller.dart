// Dart imports:
import 'dart:convert';

// Package imports:
import 'package:blockie_app/app/routes/app_router.dart';
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/app/modules/activities_management/models/activity.dart';
import 'package:blockie_app/app/modules/activities_management/models/subactivity.dart';
import 'package:blockie_app/app/modules/projects_management/controllers/projects_management_controller.dart';
import 'package:blockie_app/app/modules/subactivities_management/controllers/subactivities_management_controller.dart';
import 'package:blockie_app/app/routes/app_pages.dart';
import 'package:blockie_app/data/repositories/projects_management_repository.dart';

part 'activities_management_controller_router.dart';

class ActivitiesManagementController extends GetxController {
  final ProjectsManagementRepository repository;

  ActivitiesManagementController({required this.repository});

  final activities = Rxn<List<Activity>>();

  @override
  void onReady() {
    super.onReady();
    getManagedActivities();
  }

  void getManagedActivities() async {
    final paginatedActivities = await repository.getManagedActivities();
    activities.value = paginatedActivities?.activities;
  }
}
