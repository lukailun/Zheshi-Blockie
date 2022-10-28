// Package imports:
import 'package:blockie_app/data/repositories/project_repository.dart';
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/app/modules/ticket_checking/controllers/ticket_checking_controller.dart';

class TicketCheckingBinding implements Bindings {
  final ProjectRepository projectRepository;

  TicketCheckingBinding({required this.projectRepository});

  @override
  void dependencies() {
    Get.lazyPut(() => TicketCheckingController(repository: projectRepository));
  }
}
