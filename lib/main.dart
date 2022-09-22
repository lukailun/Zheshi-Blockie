import 'package:blockie_app/services/anyweb_service.dart';
import 'package:blockie_app/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:blockie_app/pages/project_groups.dart';
import 'package:blockie_app/routes/app_pages.dart';
import 'package:get/get.dart';

void main() {
  _initServices();
  runApp(GetMaterialApp(
    title: 'BLOCKIE',
    initialRoute: '/',
    getPages: AppPages.routes,
    home: const ProjectGroups(),
    theme: ThemeData(
        appBarTheme: const AppBarTheme(elevation: 0),
        fontFamily: "--apple-system"),
  ));
}

void _initServices() {
  Get.put(AuthService());
  Get.put(AnyWebService());
}
