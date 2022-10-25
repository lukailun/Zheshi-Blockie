// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/app/modules/project_management/controllers/project_management_controller.dart';
import 'package:blockie_app/models/app_theme_data.dart';
import 'package:blockie_app/widgets/basic_app_bar.dart';

class ProjectManagementView extends GetView<ProjectManagementController> {
  const ProjectManagementView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppThemeData.primaryColor,
      appBar: BasicAppBar(title: '活动管理'),
      body: Container(),
    );
  }
}
