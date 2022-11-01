// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/app/modules/hold_verification/controllers/hold_verification_controller.dart';
import 'package:blockie_app/data/repositories/project_management_repository.dart';

class HoldVerificationBinding implements Bindings {
  final ProjectManagementRepository projectManagementRepository;

  HoldVerificationBinding({required this.projectManagementRepository});

  @override
  void dependencies() {
    Get.lazyPut(() =>
        HoldVerificationController(repository: projectManagementRepository));
  }
}
