// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

// Project imports:
import 'package:blockie_app/app/modules/settings/models/settings_item_groups.dart';
import 'package:blockie_app/app/modules/settings/views/settings_item_group_tile.dart';
import 'package:blockie_app/extensions/extensions.dart';
import 'package:blockie_app/models/app_theme_data.dart';
import 'package:blockie_app/services/anyweb_service.dart';
import 'package:blockie_app/widgets/basic_app_bar.dart';
import 'package:blockie_app/widgets/basic_dialog.dart';
import 'package:blockie_app/widgets/basic_elevated_button.dart';
import 'package:blockie_app/widgets/loading_indicator.dart';
import '../controllers/settings_controller.dart';

class SettingsView extends GetView<SettingsController> {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final Widget title = const Text('设置')
        .textColor(Colors.white)
        .fontSize(24)
        .fontWeight(FontWeightCompat.semiBold)
        .textShadow(color: const Color(0x40000000), offset: const Offset(2, 2));
    const expanded = Expanded(child: SizedBox());
    final logoutButton = SizedBox(
      width: double.infinity,
      child: Center(
        child: SizedBox(
          width: 105,
          height: 36,
          child: BasicElevatedButton(
            title: '退出登录',
            onTap: () {
              Get.dialog(BasicDialog(
                title: '提示',
                message: '确定登出吗？',
                onPositiveButtonTap: controller.openLogoutDialog,
                onNegativeButtonTap: () => Get.back(),
              ));
            },
          ),
        ),
      ),
    ).paddingOnly(bottom: 97);

    return Scaffold(
      backgroundColor: AppThemeData.primaryColor,
      appBar: BasicAppBar(),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: AppThemeData.primaryColor,
        child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [title] +
                _getItemGroupTiles(version: controller.version.value) +
                [expanded, logoutButton],
          ),
        ).paddingSymmetric(horizontal: 20),
      ),
    );
  }

  List<Widget> _getItemGroupTiles({
    required String version,
  }) {
    final groups = SettingsItemGroups.initial(
      phoneNumber:
          controller.displayPhoneNumber(controller.initialPhoneNumber.value),
      version: version,
      termsOfServiceOnTap: () => controller.goToTermsOfService(),
      privacyPolicyOnTap: () => controller.goToPrivacyPolicy(),
      activityManagementOnTap: () => controller.goToActivityManagement(),
    );
    final List<Widget> itemGroupTiles =
        groups.map((group) => SettingsItemGroupTile(group: group)).toList();
    return itemGroupTiles;
  }
}
