// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/app/modules/projects_management/controllers/projects_management_controller.dart';

class ProjectsManagementBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProjectsManagementController());
  }
}
