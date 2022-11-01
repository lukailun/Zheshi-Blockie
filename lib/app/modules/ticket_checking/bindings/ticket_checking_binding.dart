// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/app/modules/ticket_checking/controllers/ticket_checking_controller.dart';
import 'package:blockie_app/data/repositories/project_management_repository.dart';

class TicketCheckingBinding implements Bindings {
  final ProjectManagementRepository projectManagementRepository;

  TicketCheckingBinding({required this.projectManagementRepository});

  @override
  void dependencies() {
    Get.lazyPut(() => TicketCheckingController(repository: projectManagementRepository));
  }
}
