// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/app/routes/app_pages.dart';
import 'package:blockie_app/services/anyweb_service.dart';
import 'package:blockie_app/services/auth_service.dart';
import 'package:blockie_app/services/wechat_service/wechat_service.dart';

void main() {
  _initServices();
  runApp(
    GetMaterialApp(
      title: 'BLOCKIE',
      getPages: AppPages.routes,
      theme: ThemeData(
          appBarTheme: const AppBarTheme(elevation: 0),
          fontFamily: "--apple-system"),
    ),
  );
}

void _initServices() {
  Get.put(AuthService());
  Get.put(AnyWebService());
  Get.put(WechatService());
}
