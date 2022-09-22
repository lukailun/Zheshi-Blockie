import 'package:get/get.dart';
import 'dart:html' as html;
import 'dart:convert';

enum AnyWebMethod {
  accounts,
  logout,
}

extension AnyWebMethodExtension on AnyWebMethod {
  String get value {
    switch (this) {
      case AnyWebMethod.accounts:
        return 'cfx_accounts';
      case AnyWebMethod.logout:
        return 'anyweb_logout';
    }
  }
}

class AnyWebService extends GetxService {
  static AnyWebService get to => Get.find();

  final accountsCode = Rxn<String>();
  final logout = Rxn<bool>();

  @override
  void onInit() {
    html.window.onMessage.listen((html.MessageEvent event) {
      final data = jsonDecode(event.data);
      final String status = data['status'];
      final method =
          AnyWebMethod.values.firstWhere((it) => it.value == data['method']);
      if (status != "ok") {
        throw Exception("error: ${method.value} failed");
      }
      switch (method) {
        case AnyWebMethod.accounts:
          accountsCode.value = data["data"]["code"];
          break;
        case AnyWebMethod.logout:
          logout.value = true;
          break;
      }
    });
    super.onInit();
  }
}
