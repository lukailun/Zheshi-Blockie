part of 'activities_management_controller.dart';

extension ActivitiesManagementControllerRouter
    on ActivitiesManagementController {
  void goToSubactivitiesManagement(
    String name,
    List<Subactivity> subactivities,
  ) {
    final parameters = {
      ActivitiesManagementParameter.subactivities: jsonEncode(subactivities),
      ActivitiesManagementParameter.name: name,
    };
    AppRouter.toNamed(Routes.subactivitiesManagement, parameters: parameters);
  }

  void goToProjectsManagement(String name, Subactivity subactivity) {
    final parameters = {
      ProjectsManagementParameter.id: subactivity.id,
      ProjectsManagementParameter.name: '$name - ${subactivity.name}',
    };
    AppRouter.toNamed(Routes.projectsManagement, parameters: parameters);
  }
}
