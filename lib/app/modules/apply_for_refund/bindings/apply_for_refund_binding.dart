import 'package:get/get.dart';
import 'package:blockie_app/app/modules/apply_for_refund/controllers/apply_for_refund_controller.dart';

class ApplyForRefundBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ApplyForRefundController());
  }
}
