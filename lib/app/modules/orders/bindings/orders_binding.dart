import 'package:get/get.dart';
import 'package:blockie_app/app/modules/orders/controllers/orders_controller.dart';

class OrdersBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OrdersController());
  }
}
