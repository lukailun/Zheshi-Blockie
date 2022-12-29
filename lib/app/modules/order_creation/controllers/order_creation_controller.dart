import 'package:blockie_app/data/models/cart.dart';
import 'package:blockie_app/data/repositories/finance_repository.dart';
import 'package:get/get.dart';

part 'order_creation_controller_router.dart';

class OrderCreationController extends GetxController {
  final FinanceRepository financeRepository;

  OrderCreationController({required this.financeRepository});

  final id = Get.parameters[OrderCreationParameter.id] ?? '';
  final a = '1'.obs;

  final cart = Rxn<Cart>();

  @override
  void onReady() {
    super.onReady();
    getCart();
  }

  void getCart() async {
    cart.value = await financeRepository.getCart(id);
  }
}

class OrderCreationParameter {
  static const id = 'id';
}
