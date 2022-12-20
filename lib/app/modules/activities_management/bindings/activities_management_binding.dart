// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/app/modules/activities_management/controllers/activities_management_controller.dart';
import 'package:blockie_app/data/repositories/projects_management_repository.dart';

class ActivitiesManagementBinding implements Bindings {
  ActivitiesManagementBinding({
    required this.projectsManagementRepository,
  });

  final ProjectsManagementRepository projectsManagementRepository;

  @override
  void dependencies() {
    Get.lazyPut(
        () => ActivitiesManagementController(repository: projectsManagementRepository));
  }
}
