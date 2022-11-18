// Dart imports:
import 'dart:math';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';
import 'package:statsfl/statsfl.dart';

// Project imports:
import 'package:blockie_app/app/routes/app_pages.dart';
import 'package:blockie_app/models/app_theme_data.dart';
import 'package:blockie_app/models/environment.dart';
import 'package:blockie_app/models/platform_info.dart';
import 'package:blockie_app/services/debug_service.dart';

class BlockieApp extends StatelessWidget {
  const BlockieApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return StatsFl(
          isEnabled:
              Environment.isDevelopment && DebugService.to.showsFps.value,
          maxFps: 120,
          align: Alignment.bottomLeft,
          child: GetMaterialApp(
            title: DebugService.to.isDevTitle.value
                ? Environment.appTitle
                : Environment.appTitle.replaceAll('[DEV] ', ''),
            getPages: AppPages.routes,
            debugShowCheckedModeBanner: false,
            initialRoute: Routes.activities,
            defaultTransition: Transition.cupertino,
            theme: ThemeData(
              appBarTheme: const AppBarTheme(elevation: 0),
              fontFamily: '--apple-system',
            ),
            builder: (context, widget) {
              return MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
                child: Material(
                  color: const Color(0xFFF0F2F5),
                  child: Center(
                    child: Container(
                      color: AppThemeData.primaryColor,
                      width: PlatformInfo.isWeb
                          ? min(Get.width, 450)
                          : double.infinity,
                      height: double.infinity,
                      child: widget ?? const SizedBox(),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
