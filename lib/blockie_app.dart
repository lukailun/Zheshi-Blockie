// Dart imports:
import 'dart:math';

// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';
import 'package:statsfl/statsfl.dart';

// Project imports:
import 'package:blockie_app/app/routes/app_pages.dart';
import 'package:blockie_app/models/app_theme_data.dart';
import 'package:blockie_app/models/environment.dart';

class BlockieApp extends StatelessWidget {
  const BlockieApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StatsFl(
      isEnabled: Environment.isDevelopment,
      maxFps: 120,
      align: Alignment.bottomLeft,
      child: GetMaterialApp(
        title: Environment.appTitle,
        getPages: AppPages.routes,
        debugShowCheckedModeBanner: false,
        initialRoute: Routes.activities,
        defaultTransition: Transition.cupertino,
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
}
