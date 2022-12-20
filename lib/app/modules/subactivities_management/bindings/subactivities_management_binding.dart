// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/app/modules/subactivities_management/controllers/subactivities_management_controller.dart';

class SubactivitiesManagementBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SubactivitiesManagementController());
  }
}
