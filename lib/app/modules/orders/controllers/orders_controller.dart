import 'package:blockie_app/app/modules/orders/models/order.dart';
import 'package:blockie_app/data/repositories/finance_repository.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

part 'orders_controller_router.dart';

class OrdersController extends GetxController {
  final FinanceRepository financeRepository;

  OrdersController({required this.financeRepository});

  final refreshController = RefreshController(initialRefresh: false);
  final orders = Rxn<List<Order>>();
  int pageIndex = 1;

  @override
  void onReady() {
    super.onReady();
    getOrders(isRefresh: true);
  }

  Future<void> getOrders({required bool isRefresh}) async {
    pageIndex = isRefresh ? 1 : pageIndex + 1;
    final paginatedOrders = await financeRepository.getOrders(pageIndex);
    if (paginatedOrders == null) {
      if (isRefresh) {
        refreshController.refreshFailed();
      } else {
        refreshController.loadFailed();
      }
      return;
    }
    if (isRefresh) {
      refreshController.resetNoData();
      refreshController.refreshCompleted();
      orders.value = paginatedOrders.orders;
    } else {
      if (paginatedOrders.orders.isNotEmpty) {
        refreshController.loadComplete();
        orders.value = (orders.value ?? []) + paginatedOrders.orders;
      } else {
        refreshController.loadNoData();
      }
    }
  }
}
