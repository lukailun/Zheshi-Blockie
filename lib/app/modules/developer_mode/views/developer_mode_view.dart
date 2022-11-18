// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/app/modules/developer_mode/controllers/developer_mode_controller.dart';
import 'package:blockie_app/app/modules/settings/models/settings_item_groups.dart';
import 'package:blockie_app/app/modules/settings/views/settings_item_tile.dart';
import 'package:blockie_app/extensions/extensions.dart';
import 'package:blockie_app/models/app_theme_data.dart';
import 'package:blockie_app/models/environment.dart';
import 'package:blockie_app/services/debug_service.dart';
import 'package:blockie_app/widgets/basic_app_bar.dart';

class DeveloperModeView extends GetView<DeveloperModeController> {
  const DeveloperModeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final Widget title = const Text('开发者模式')
          .textColor(Colors.white)
          .fontSize(24)
          .fontWeight(FontWeightCompat.semiBold)
          .textShadow(
              color: const Color(0x40000000), offset: const Offset(2, 2));
      final items = [
        SettingsItem(
          title: 'App 标题',
          content: DebugService.to.isDevTitle.value
              ? Environment.appTitle
              : Environment.appTitle.replaceAll('[DEV] ', ''),
          arrowIsVisible: false,
          onTap: () => DebugService.to.isDevTitle.value =
              !DebugService.to.isDevTitle.value,
        ),
        SettingsItem(title: '网络日志', onTap: controller.goToHttpLog),
        SettingsItem(
          title: 'FPS',
          content: DebugService.to.showsFps.value ? '已显示' : '已隐藏',
          arrowIsVisible: false,
          onTap: () =>
              DebugService.to.showsFps.value = !DebugService.to.showsFps.value,
        ),
      ];
      final tiles = items.map((item) => SettingsItemTile(item: item)).toList();

      return Scaffold(
        backgroundColor: AppThemeData.primaryColor,
        appBar: BasicAppBar(),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          color: AppThemeData.primaryColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [title] + tiles,
          ).paddingSymmetric(horizontal: 20),
        ),
      );
    });
  }
}
