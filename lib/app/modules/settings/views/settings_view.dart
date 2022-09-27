import 'package:blockie_app/models/app_theme_data.dart';
import 'package:blockie_app/extensions/extensions.dart';
import 'package:blockie_app/app/modules/settings/models/settings_item_groups.dart';
import 'package:blockie_app/app/modules/settings/views/settings_item_group_tile.dart';
import 'package:blockie_app/services/anyweb_service.dart';
import 'package:blockie_app/widgets/basic_dialog.dart';
import 'package:blockie_app/widgets/basic_elevated_button.dart';
import 'package:blockie_app/widgets/loading_indicator.dart';
import 'package:blockie_app/widgets/screen_bound.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:blockie_app/widgets/basic_app_bar.dart';
import '../controllers/settings_controller.dart';

class SettingsView extends GetView<SettingsController> {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final logoutLoadingIndicator = Stack(
      children: [
        Opacity(
          opacity: 0,
          alwaysIncludeSemantics: true,
          child: HtmlElementView(viewType: AnyWebMethod.logout.value),
        ),
        const LoadingIndicator(),
      ],
    );

    final groups = SettingsItemGroups.initial(
        controller.displayPhoneNumber(controller.initialPhoneNumber.value),
        '1.0.0');
    final List<Widget> itemGroupTiles =
        groups.map((group) => SettingsItemGroupTile(group: group)).toList();
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
                onPositiveButtonTap: () {
                  Get.back();
                  controller.isLoggingOut.value = true;
                },
                onNegativeButtonTap: () => Get.back(),
              ));
            },
          ),
        ),
      ),
    ).paddingOnly(bottom: 97);
    return ScreenBoundary(
      padding: 0,
      body: Scaffold(
        backgroundColor: AppThemeData.primaryColor,
        appBar: BasicAppBar(),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          color: AppThemeData.primaryColor,
          child: Obx(
            () => Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [title] + itemGroupTiles + [expanded, logoutButton],
                ),
                if (controller.isLoggingOut.value) logoutLoadingIndicator,
              ],
            ),
          ).paddingSymmetric(horizontal: 20),
        ),
      ),
    );
  }
}
