// Dart imports:
import 'dart:convert';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/app/modules/activities_management/models/activity.dart';
import 'package:blockie_app/app/modules/activities_management/models/project.dart';
import 'package:blockie_app/app/modules/add_whitelist/controllers/add_whitelist_controller.dart';
import 'package:blockie_app/app/modules/airdrop_nft/controllers/airdrop_nft_controller.dart';
import 'package:blockie_app/app/modules/hold_verification/controllers/hold_verification_controller.dart';
import 'package:blockie_app/app/modules/projects_management/controllers/projects_management_controller.dart';
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

  void openProjectOperationDialog(Project project) {
    Get.projectsManagementDialog(
      project: project,
      ticketCheckingOnTap: () => _goToTicketChecking(project),
      addWhitelistOnTap: () => _goToAddWhitelist(project),
      airdropNftOnTap: () => _goToAirdropNft(project),
      holdVerificationOnTap: () => _goToHoldVerification(project),
    );
  }

  void _goToTicketChecking(Project project) {
    final parameters = {
      TicketCheckingParameter.id: project.id,
    };
    Get.toNamed(Routes.ticketChecking, parameters: parameters);
  }

  void _goToAddWhitelist(Project project) {
    final parameters = {
      AddWhitelistParameter.id: project.id,
    };
    Get.toNamed(Routes.addWhitelist, parameters: parameters);
  }

  void _goToAirdropNft(Project project) {
    final parameters = {
      AirdropNftParameter.id: project.id,
    };
    Get.toNamed(Routes.airdropNft, parameters: parameters);
  }

  void _goToHoldVerification(Project project) {
    final parameters = {
      HoldVerificationParameter.id: project.id,
    };
    Get.toNamed(Routes.holdVerification, parameters: parameters);
  }
}
