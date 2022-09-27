import 'package:blockie_app/widgets/message_toast.dart';
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

class AnyWebEvent {
  final bool isSuccessful;
  final dynamic data;
  final int timestamp;

  AnyWebEvent({
    required this.isSuccessful,
    this.data,
    required this.timestamp,
  });

  static AnyWebEvent empty = AnyWebEvent(isSuccessful: false, timestamp: 0);

  @override
  String toString() {
    return "isSuccessful: $isSuccessful, data: ${data.toString()}, timestamp: $timestamp}";
  }
}

extension AnyWebEventExtension on AnyWebEvent {
  AnyWebEvent updateData(dynamic data) {
    return AnyWebEvent(
        isSuccessful: isSuccessful, data: data, timestamp: timestamp);
  }
}

class AnyWebService extends GetxService {
  static AnyWebService get to => Get.find();

  final accountsCode = AnyWebEvent.empty.obs;
  final logout = AnyWebEvent.empty.obs;

  @override
  void onInit() {
    html.window.onMessage.listen((html.MessageEvent messageEvent) {
      final data = jsonDecode(messageEvent.data);
      final String status = data['status'];
      final method =
          AnyWebMethod.values.firstWhere((it) => it.value == data['method']);
      final isSuccessful = status == "ok";
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final event =
          AnyWebEvent(isSuccessful: isSuccessful, timestamp: timestamp);
      switch (method) {
        case AnyWebMethod.accounts:
          accountsCode.value = event.updateData(data?["data"]?["code"]);
          break;
        case AnyWebMethod.logout:
          logout.value = event;
          break;
      }
    });
    super.onInit();
  }
}
