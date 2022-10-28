// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/app/modules/activity_management/controllers/activity_management_controller.dart';

class ActivityManagementBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ActivityManagementController());
  }
}
