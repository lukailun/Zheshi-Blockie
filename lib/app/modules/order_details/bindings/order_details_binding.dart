import 'package:get/get.dart';
import 'package:blockie_app/app/modules/order_details/controllers/order_details_controller.dart';

class OrderDetailsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OrderDetailsController());
  }
}
