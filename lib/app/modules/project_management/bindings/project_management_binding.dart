// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/app/modules/project_management/controllers/project_management_controller.dart';
import 'package:blockie_app/data/repositories/project_repository.dart';

class ProjectManagementBinding implements Bindings {
  ProjectManagementBinding({
    required ProjectRepository projectRepository,
  }) : _projectRepository = projectRepository;
  final ProjectRepository _projectRepository;

  @override
  void dependencies() {
    Get.lazyPut(
        () => ProjectManagementController(repository: _projectRepository));
  }
}
