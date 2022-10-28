// Dart imports:
import 'dart:convert';

// Package imports:
import 'package:blockie_app/app/modules/ticket_checking/controllers/ticket_checking_controller.dart';
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/app/modules/projects_management/models/project.dart';
import 'package:blockie_app/app/routes/app_pages.dart';
import 'package:blockie_app/widgets/project_operation_dialog.dart';

class ActivityManagementController extends GetxController {
  final _projects =
      Get.parameters[ActivityManagementParameter.projects] as String;
  final name = Get.parameters[ActivityManagementParameter.name] as String;
  List<Project> projects = [];

  @override
  void onInit() {
    super.onInit();
    projects = (jsonDecode(_projects) as List)
        .map((it) => Project.fromJson(it))
        .toList();
  }

  void openProjectOperationDialog(Project project) {
    Get.projectOperationDialog(
      project: project,
      ticketCheckingOnTap: () => _goToTicketChecking(project),
    );
  }

  void _goToTicketChecking(Project project) {
    final parameters = {
      TicketCheckingParameter.id: project.id,
    };
    Get.toNamed(Routes.ticketChecking, parameters: parameters);
  }
}

class ActivityManagementParameter {
  static const name = 'name';
  static const projects = 'projects';
}
