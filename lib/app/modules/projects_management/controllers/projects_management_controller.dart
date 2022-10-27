// Dart imports:
import 'dart:convert';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/app/modules/activity_management/controllers/activity_management_controller.dart';
import 'package:blockie_app/app/modules/projects_management/models/paginated_projects.dart';
import 'package:blockie_app/app/modules/projects_management/models/project.dart';
import 'package:blockie_app/app/routes/app_pages.dart';
import 'package:blockie_app/data/repositories/project_repository.dart';

class ProjectsManagementController extends GetxController {
  final ProjectRepository repository;

  ProjectsManagementController({required this.repository});

  final projects = Rxn<PaginatedProjects>();

  @override
  void onReady() {
    super.onReady();
    _getProjectsList();
  }

  void _getProjectsList() async {
    final paginatedProjects = await repository.getProjects();
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
