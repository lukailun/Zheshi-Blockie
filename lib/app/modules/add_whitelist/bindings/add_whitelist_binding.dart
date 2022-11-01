// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/app/modules/add_whitelist/controllers/add_whitelist_controller.dart';
import 'package:blockie_app/data/repositories/project_management_repository.dart';

class AddWhitelistBinding implements Bindings {
  final ProjectManagementRepository projectManagementRepository;

  AddWhitelistBinding({required this.projectManagementRepository});

  @override
  void dependencies() {
    Get.lazyPut(() => AddWhitelistController(repository: projectManagementRepository));
  }
}
