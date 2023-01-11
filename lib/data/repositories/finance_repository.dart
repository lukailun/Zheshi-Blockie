// Project imports:
import 'package:blockie_app/app/modules/order_creation/models/wechat_pay_parameters.dart';
import 'package:blockie_app/app/modules/orders/models/paginated_orders.dart';
import 'package:blockie_app/data/apis/blockie_api/blockie_api.dart';
import 'package:blockie_app/data/models/cart.dart';

class FinanceRepository {
  final BlockieApi remoteApi;

  FinanceRepository({required this.remoteApi});

  Future<Cart?> getCart(String id) => remoteApi.getCart(id);

  Future<Cart?> updateCart(String id, int amount) =>
      remoteApi.updateCart(id, amount);

  Future<WechatPayParameters?> submitOrder(String id) =>
      remoteApi.submitOrder(id);

  Future<PaginatedOrders?> getOrders(int pageIndex) =>
      remoteApi.getOrders(pageIndex: pageIndex);
}
