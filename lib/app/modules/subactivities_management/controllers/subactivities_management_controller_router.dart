part of 'subactivities_management_controller.dart';

extension SubactivitiesManagementControllerRouter
    on SubactivitiesManagementController {
  void goToProjectsManagement(String id, String name) {
    final parameters = {
      ProjectsManagementParameter.id: id,
      ProjectsManagementParameter.name: name,
    };
    AppRouter.toNamed(Routes.projectsManagement, parameters: parameters);
  }
}
