// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/app/modules/ticket_checking/controllers/ticket_checking_controller.dart';

class TicketCheckingBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TicketCheckingController());
  }
}
