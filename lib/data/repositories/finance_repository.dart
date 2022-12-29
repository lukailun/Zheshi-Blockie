// Project imports:
import 'package:blockie_app/data/apis/blockie_api/blockie_api.dart';
import 'package:blockie_app/data/models/cart.dart';

class FinanceRepository {
  final BlockieApi remoteApi;

  FinanceRepository({required this.remoteApi});

  Future<Cart?> getCart(String id) => remoteApi.getCart(id);
}
