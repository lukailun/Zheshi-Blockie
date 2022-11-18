// Dart imports:
import 'dart:convert';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/app/modules/activities_management/models/subactivity.dart';
import 'package:blockie_app/app/modules/add_whitelist/controllers/add_whitelist_controller.dart';
import 'package:blockie_app/app/modules/airdrop_nft/controllers/airdrop_nft_controller.dart';
import 'package:blockie_app/app/modules/hold_verification/controllers/hold_verification_controller.dart';
import 'package:blockie_app/app/modules/projects_management/controllers/projects_management_controller.dart';
import 'package:blockie_app/app/modules/ticket_checking/controllers/ticket_checking_controller.dart';
import 'package:blockie_app/app/routes/app_pages.dart';
import 'package:blockie_app/widgets/projects_management_dialog.dart';

class SubactivitiesManagementController extends GetxController {
  final _subactivities =
      Get.parameters[ActivitiesManagementParameter.subactivities] as String;
  final name = Get.parameters[ActivitiesManagementParameter.name] as String;
  List<Subactivity> subactivities = [];

  @override
  void onInit() {
    super.onInit();
    subactivities = (jsonDecode(_subactivities) as List)
        .map((it) => Subactivity.fromJson(it))
        .toList();
  }

  void goToProjectsManagement(String id, String name) {
    final parameters = {
      ProjectsManagementParameter.id: id,
      ProjectsManagementParameter.name: name,
    };
    Get.toNamed(Routes.projectsManagement, parameters: parameters);
  }
}

class ActivitiesManagementParameter {
  static const name = 'name';
  static const subactivities = 'subactivities';
}
