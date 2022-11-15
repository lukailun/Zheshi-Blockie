// Dart imports:
import 'dart:math';

// Flutter imports:
import 'package:blockie_app/models/platform_info.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';
import 'package:statsfl/statsfl.dart';

// Project imports:
import 'package:blockie_app/app/routes/app_pages.dart';
import 'package:blockie_app/models/app_theme_data.dart';
import 'package:blockie_app/models/environment.dart';

class BlockieApp extends StatelessWidget {
  BlockieApp({Key? key}) : super(key: key);
  final showsFpsStats = true.obs;

  @override
  Widget build(BuildContext context) {
    final app = GetMaterialApp(
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
                width:
                    PlatformInfo.isWeb ? min(Get.width, 450) : double.infinity,
                height: double.infinity,
                child: widget ?? const SizedBox(),
              ),
            ),
          ),
        );
      },
    );
    if (!Environment.isDevelopment) {
      return app;
    }
    return GestureDetector(
      onLongPress: () => showsFpsStats.value = !showsFpsStats.value,
      child: Obx(
        () => StatsFl(
          isEnabled: showsFpsStats.value,
          maxFps: 120,
          align: Alignment.bottomLeft,
          child: app,
        ),
      ),
    );
  }
}
