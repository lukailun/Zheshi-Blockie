// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/app/modules/project_details/controllers/project_details_controller.dart';
import 'package:blockie_app/data/repositories/project_repository.dart';

class ProjectDetailsBinding implements Bindings {
  ProjectDetailsBinding({
    required ProjectRepository projectRepository,
  }) : _projectRepository = projectRepository;
  final ProjectRepository _projectRepository;

  @override
  void dependencies() {
    Get.lazyPut(
      () => ProjectDetailsController(repository: _projectRepository),
    );
  }
}
