// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/app/modules/projects_management/controllers/projects_management_controller.dart';
import 'package:blockie_app/data/repositories/project_management_repository.dart';

class ProjectsManagementBinding implements Bindings {
  ProjectsManagementBinding({
    required this.projectManagementRepository,
  });

  final ProjectManagementRepository projectManagementRepository;

  @override
  void dependencies() {
    Get.lazyPut(
        () => ProjectsManagementController(repository: projectManagementRepository));
  }
}
