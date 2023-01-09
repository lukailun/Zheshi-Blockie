import 'dart:convert';
import 'dart:html' as html;
import 'package:blockie_app/app/modules/order_creation/models/wechat_pay_parameters.dart';
import 'package:blockie_app/data/apis/blockie_api/blockie_url_builder.dart';
import 'package:blockie_app/data/models/cart.dart';
import 'package:blockie_app/data/models/platform_info.dart';
import 'package:blockie_app/data/repositories/finance_repository.dart';
import 'package:blockie_app/services/auth_service.dart';
import 'package:blockie_app/services/wechat_service/wechat_js_sdk/wechat_js_sdk.dart';
import 'package:blockie_app/utils/anchor_utils.dart';
import 'package:blockie_app/widgets/basic_two_button_dialog.dart';
import 'package:blockie_app/widgets/message_toast.dart';
import 'package:get/get.dart';

part 'order_creation_controller_router.dart';

class OrderCreationController extends GetxController {
  final FinanceRepository financeRepository;

  OrderCreationController({required this.financeRepository});

  final id = Get.parameters[OrderCreationParameter.id] ?? '';
  final openId = Get.parameters[OrderCreationParameter.openId] ?? '';

  final cart = Rxn<Cart>();

  @override
  void onReady() {
    super.onReady();
    if (!PlatformInfo.isWechatBrowser) {
      return showCantPayDialog();
    }
    if (openId.isEmpty) {
      wechatAuth();
    } else {
      getCart();
    }
  }

  void wechatAuth() {
    final currentHref = html.window.location.href;
    final userInfo = AuthService.to.userInfo.value;
    if (userInfo == null) {
      return;
    }
    final urlComponents = currentHref.split('#');
    final redirectUrlPrefix = urlComponents.first;
    final redirectUrlSuffix =
        urlComponents.length > 1 ? urlComponents[1] : null;
    final redirectUrl = BlockieUrlBuilder().buildGetWechatSilentAuthRedirectUrl(
        userInfo.id, redirectUrlPrefix, redirectUrlSuffix);
    final wechatAuthorizationUrl =
        BlockieUrlBuilder.buildWechatAuthorizationUrl(redirectUrl);
    html.window.location.href = wechatAuthorizationUrl;
  }

  void getCart() async {
    cart.value = await financeRepository.getCart(id);
  }

  void submitOrder() async {
    final parameters = await financeRepository.submitOrder(id);
    if (parameters == null) {
      return;
    }
    chooseWechatPay(parameters);
  }

  void chooseWechatPay(WechatPayParameters parameters) {
    wechatChooseWechatPay(
      WechatChooseWechatPayParams(
        timestamp: parameters.timestamp,
        nonceStr: parameters.nonceString,
        package: parameters.package,
        signType: parameters.signType,
        paySign: parameters.paySign,
        success: (res) {
          MessageToast.showMessage(jsonEncode(res));
        },
      ),
    );
  }

  void increaseGoods(String id) {
    final cartValue = cart.value;
    if (cartValue == null) {
      return;
    }
    final goods = cartValue.goods.firstWhere((it) => it.id == id);
    if (goods.amount >= goods.inventory) {
      return;
    }
    _updateCart(id, goods.amount + 1);
  }

  void decreaseGoods(String id) {
    final cartValue = cart.value;
    if (cartValue == null) {
      return;
    }
    final goods = cartValue.goods.firstWhere((it) => it.id == id);
    if (goods.amount <= 0) {
      return;
    }
    _updateCart(id, goods.amount - 1);
  }

  void _updateCart(String id, int amount) async {
    cart.value = await financeRepository.updateCart(id, amount);
  }
}

class OrderCreationParameter {
  static const id = 'id';
  static const openId = 'openid';
}
