// Dart imports:
import 'dart:math';

// Flutter imports:
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

// Project imports:
import 'package:blockie_app/app/routes/app_pages.dart';
import 'package:blockie_app/models/app_theme_data.dart';
import 'package:blockie_app/services/anyweb_service.dart';
import 'package:blockie_app/services/auth_service.dart';
import 'package:blockie_app/services/wechat_service/wechat_service.dart';

void main() async {
  // await dotenv.load(fileName: 'dev.env');
  WidgetsFlutterBinding.ensureInitialized();
  _initServices();
  runApp(
    GetMaterialApp(
      title: 'BLOCKIE',
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(elevation: 0),
        fontFamily: "--apple-system",
      ),
      builder: (context, widget) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
          child: Material(
            color: const Color(0xFFF0F2F5),
            child: Center(
              child: Container(
                color: AppThemeData.primaryColor,
                width: kIsWeb ? min(Get.width, 450) : double.infinity,
                height: double.infinity,
                child: widget ?? const SizedBox(),
              ),
            ),
          ),
        );
      },
    ),
  );
}

void _initServices() {
  Get.put(AuthService());
  Get.put(AnyWebService());
  Get.put(WechatService());
}
