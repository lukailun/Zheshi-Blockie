// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/app/modules/add_whitelist/controllers/add_whitelist_controller.dart';
import 'package:blockie_app/data/repositories/projects_management_repository.dart';

class AddWhitelistBinding implements Bindings {
  final ProjectsManagementRepository projectsManagementRepository;

  AddWhitelistBinding({required this.projectsManagementRepository});

  @override
  void dependencies() {
    Get.lazyPut(
        () => AddWhitelistController(repository: projectsManagementRepository));
  }
}
