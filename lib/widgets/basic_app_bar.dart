import 'package:blockie_app/models/app_bar_button_item.dart';
import 'package:blockie_app/extensions/extensions.dart';
import 'package:blockie_app/widgets/basic_flat_button.dart';
import 'package:blockie_app/widgets/basic_icon_button.dart';
import 'package:blockie_app/widgets/basic_popup_menu_button.dart';
import 'package:blockie_app/widgets/basic_popup_menu_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum AppBarButtonStyle {
  elevated,
  flat,
}

final _popupMenuButtonController = BasicPopupMenuButtonController();

class BasicAppBar extends StatelessWidget with PreferredSizeWidget {
  final String? title;
  final bool showsBackButton;
  final Widget? avatar;
  final bool showsLogo;
  final List<AppBarButtonItem>? actionItems;
  final AppBarButtonStyle buttonStyle;

  BasicAppBar({
    Key? key,
    this.title,
    this.showsBackButton = true,
    this.showsLogo = false,
    this.actionItems,
    this.avatar,
    this.buttonStyle = AppBarButtonStyle.elevated,
  }) : super(key: key);

  double get toolbarHeight => showsLogo ? 120 : 80;

  double get paddingTop => showsLogo ? 30 : 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget>? actions = actionItems?.map((item) {
      final button = buttonStyle == AppBarButtonStyle.elevated
          ? BasicIconButton(
              assetName: item.assetName, size: 34, onTap: item.onTap)
          : BasicFlatButton(
              assetName: item.assetName, size: 34, onTap: item.onTap);
      return (item.items ?? []).isEmpty
          ? button.paddingOnly(right: 13)
          : BasicPopupMenuButton(
              controller: _popupMenuButtonController,
              menuBuilder: () => Column(
                children: (item.items ?? [])
                    .asMap()
                    .entries
                    .map((it) => BasicPopupMenuItem(
                          item: it.value,
                          controller: _popupMenuButtonController,
                          showsDivider: it.key != (item.items ?? []).length - 1,
                        ))
                    .toList(),
              ),
              pressType: PressType.singleClick,
              child: button,
            ).paddingOnly(right: 13);
    }).toList();
    final backButton = Visibility(
      visible: showsBackButton,
      child: BasicFlatButton(
        assetName: "images/app_bar/back.png",
        size: 34,
        onTap: () => Get.back(),
      ).paddingOnly(left: 22),
    );
    final logo = Visibility(
      visible: showsLogo,
      child: Image.asset(
        "images/app_bar/logo.png",
      ).paddingOnly(left: 22),
    );
    return AppBar(
      leading: showsLogo ? logo : backButton,
      leadingWidth: showsLogo ? double.infinity : 56,
      actions: (avatar != null ? [avatar!] : actions)
        ?..add(const SizedBox(width: 9)),
      backgroundColor: Colors.transparent,
      centerTitle: true,
      toolbarHeight: toolbarHeight,
      title: Text(
        title ?? '',
        maxLines: 2,
        textAlign: TextAlign.center,
      ).textColor(Colors.white).fontSize(20).fontWeight(FontWeightCompat.bold),
    ).paddingOnly(top: paddingTop);
  }

  @override
  Size get preferredSize => Size.fromHeight(toolbarHeight);
}
