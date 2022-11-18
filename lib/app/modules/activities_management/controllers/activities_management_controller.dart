// Dart imports:
import 'dart:convert';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/app/modules/activities_management/models/activity.dart';
import 'package:blockie_app/app/modules/activities_management/models/subactivity.dart';
import 'package:blockie_app/app/modules/add_whitelist/controllers/add_whitelist_controller.dart';
import 'package:blockie_app/app/modules/airdrop_nft/controllers/airdrop_nft_controller.dart';
import 'package:blockie_app/app/modules/hold_verification/controllers/hold_verification_controller.dart';
import 'package:blockie_app/app/modules/projects_management/controllers/projects_management_controller.dart';
import 'package:blockie_app/app/modules/subactivities_management/controllers/subactivities_management_controller.dart';
import 'package:blockie_app/app/modules/ticket_checking/controllers/ticket_checking_controller.dart';
import 'package:blockie_app/app/routes/app_pages.dart';
import 'package:blockie_app/data/repositories/projects_management_repository.dart';
import 'package:blockie_app/widgets/projects_management_dialog.dart';

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

  void goToSubactivitiesManagement(
    String name,
    List<Subactivity> subactivities,
  ) {
    final parameters = {
      ActivitiesManagementParameter.subactivities: jsonEncode(subactivities),
      ActivitiesManagementParameter.name: name,
    };
    Get.toNamed(Routes.subactivitiesManagement, parameters: parameters);
  }

  void goToProjectsManagement(String name, Subactivity subactivity) {
    final parameters = {
      ProjectsManagementParameter.id: subactivity.id,
      ProjectsManagementParameter.name: '$name - ${subactivity.name}',
    };
    Get.toNamed(Routes.projectsManagement, parameters: parameters);
  }
}
