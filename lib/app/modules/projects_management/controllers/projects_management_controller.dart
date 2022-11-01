// Dart imports:
import 'dart:convert';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/app/modules/activity_management/controllers/activity_management_controller.dart';
import 'package:blockie_app/app/modules/projects_management/models/paginated_projects.dart';
import 'package:blockie_app/app/modules/projects_management/models/project.dart';
import 'package:blockie_app/app/routes/app_pages.dart';
import 'package:blockie_app/data/repositories/project_management_repository.dart';

class ProjectsManagementController extends GetxController {
  final ProjectManagementRepository repository;

  ProjectsManagementController({required this.repository});

  final projects = Rxn<PaginatedProjects>();

  @override
  void onReady() {
    super.onReady();
    _getManagedProjectsList();
  }

  void _getManagedProjectsList() async {
    final paginatedProjects = await repository.getManagedProjects();
    projects.value = paginatedProjects;
  }

  void goToProjectManagement(
    String name,
    List<Project> projects,
  ) {
    final parameters = {
      ActivityManagementParameter.projects: jsonEncode(projects),
      ActivityManagementParameter.name: name,
    };
    Get.toNamed(Routes.activityManagement, parameters: parameters);
  }
}
