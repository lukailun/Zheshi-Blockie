// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/app/modules/ticket_checking/controllers/ticket_checking_controller.dart';
import 'package:blockie_app/data/repositories/projects_management_repository.dart';

class TicketCheckingBinding implements Bindings {
  final ProjectsManagementRepository projectsManagementRepository;

  TicketCheckingBinding({required this.projectsManagementRepository});

  @override
  void dependencies() {
    Get.lazyPut(() => TicketCheckingController(repository: projectsManagementRepository));
  }
}
