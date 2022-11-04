// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/app/modules/hold_verification/controllers/hold_verification_controller.dart';
import 'package:blockie_app/data/repositories/projects_management_repository.dart';

class HoldVerificationBinding implements Bindings {
  final ProjectsManagementRepository projectsManagementRepository;

  HoldVerificationBinding({required this.projectsManagementRepository});

  @override
  void dependencies() {
    Get.lazyPut(() =>
        HoldVerificationController(repository: projectsManagementRepository));
  }
}
