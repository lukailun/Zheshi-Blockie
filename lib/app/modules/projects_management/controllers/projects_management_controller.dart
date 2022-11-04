// Dart imports:
import 'dart:convert';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/app/modules/activities/models/project.dart';
import 'package:blockie_app/app/modules/add_whitelist/controllers/add_whitelist_controller.dart';
import 'package:blockie_app/app/modules/airdrop_nft/controllers/airdrop_nft_controller.dart';
import 'package:blockie_app/app/modules/ticket_checking/controllers/ticket_checking_controller.dart';
import 'package:blockie_app/app/routes/app_pages.dart';
import 'package:blockie_app/widgets/projects_management_dialog.dart';

class ProjectsManagementController extends GetxController {
  final _projects =
      Get.parameters[ActivitiesManagementParameter.projects] as String;
  final name = Get.parameters[ActivitiesManagementParameter.name] as String;
  List<Project> projects = [];

  @override
  void onInit() {
    super.onInit();
    projects = (jsonDecode(_projects) as List)
        .map((it) => Project.fromJson(it))
        .toList();
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
      AirdropNftParameter.id: project.id,
    };
    Get.toNamed(Routes.holdVerification, parameters: parameters);
  }
}

class ActivitiesManagementParameter {
  static const name = 'name';
  static const projects = 'projects';
}
