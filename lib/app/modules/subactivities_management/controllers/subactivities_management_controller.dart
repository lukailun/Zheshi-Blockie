// Dart imports:
import 'dart:convert';

// Package imports:
import 'package:blockie_app/app/routes/app_router.dart';
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/app/modules/activities_management/models/subactivity.dart';
import 'package:blockie_app/app/modules/projects_management/controllers/projects_management_controller.dart';
import 'package:blockie_app/app/routes/app_pages.dart';

part 'subactivities_management_controller_router.dart';

class SubactivitiesManagementController extends GetxController {
  final subactivitiesString =
      Get.parameters[ActivitiesManagementParameter.subactivities] as String;
  final name = Get.parameters[ActivitiesManagementParameter.name] as String;
  List<Subactivity> subactivities = [];

  @override
  void onInit() {
    super.onInit();
    subactivities = (jsonDecode(subactivitiesString) as List)
        .map((it) => Subactivity.fromJson(it))
        .toList();
  }
}

class ActivitiesManagementParameter {
  static const name = 'name';
  static const subactivities = 'subactivities';
}
