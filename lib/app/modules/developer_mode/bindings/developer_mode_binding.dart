// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/app/modules/developer_mode/controllers/developer_mode_controller.dart';

class DeveloperModeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DeveloperModeController());
  }
}
