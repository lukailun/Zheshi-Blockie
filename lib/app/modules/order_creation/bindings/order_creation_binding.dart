import 'package:get/get.dart';
import 'package:blockie_app/app/modules/order_creation/controllers/order_creation_controller.dart';

class OrderCreationBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OrderCreationController());
  }
}
