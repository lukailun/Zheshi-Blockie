import 'package:blockie_app/data/repositories/finance_repository.dart';
import 'package:get/get.dart';
import 'package:blockie_app/app/modules/order_creation/controllers/order_creation_controller.dart';

class OrderCreationBinding implements Bindings {
  final FinanceRepository financeRepository;

  OrderCreationBinding({required this.financeRepository});

  @override
  void dependencies() {
    Get.lazyPut(
        () => OrderCreationController(financeRepository: financeRepository));
  }
}
