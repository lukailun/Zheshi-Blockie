import 'package:blockie_app/data/repositories/finance_repository.dart';
import 'package:get/get.dart';
import 'package:blockie_app/app/modules/orders/controllers/orders_controller.dart';

class OrdersBinding implements Bindings {
  final FinanceRepository financeRepository;

  OrdersBinding({required this.financeRepository});

  @override
  void dependencies() {
    Get.lazyPut(() => OrdersController(financeRepository: financeRepository));
  }
}
