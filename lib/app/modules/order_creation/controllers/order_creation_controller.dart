import 'package:blockie_app/data/models/cart.dart';
import 'package:blockie_app/data/models/platform_info.dart';
import 'package:blockie_app/data/repositories/finance_repository.dart';
import 'package:blockie_app/widgets/basic_two_button_dialog.dart';
import 'package:get/get.dart';

part 'order_creation_controller_router.dart';

class OrderCreationController extends GetxController {
  final FinanceRepository financeRepository;

  OrderCreationController({required this.financeRepository});

  final id = Get.parameters[OrderCreationParameter.id] ?? '';

  final cart = Rxn<Cart>();

  @override
  void onReady() {
    super.onReady();
    // if (!PlatformInfo.isWechatBrowser) {
    //   return showCantPayDialog();
    // }
    getCart();
  }

  void getCart() async {
    cart.value = await financeRepository.getCart(id);
  }

  void updateCart(String id, int amount) async {
    final result = await financeRepository.updateCart(id, amount);
    cart.value = result;
  }
}

class OrderCreationParameter {
  static const id = 'id';
}
