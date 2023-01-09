import 'package:blockie_app/app/modules/orders/models/order.dart';
import 'package:blockie_app/data/repositories/finance_repository.dart';
import 'package:get/get.dart';

part 'orders_controller_router.dart';

class OrdersController extends GetxController {
  final FinanceRepository financeRepository;

  OrdersController({required this.financeRepository});

  final orders = Rxn<List<Order>>();

  @override
  void onReady() {
    super.onReady();
    getOrders();
  }

  void getOrders() async {
    final paginatedOrders = await financeRepository.getOrders();
    orders.value = paginatedOrders?.orders;
  }
}
