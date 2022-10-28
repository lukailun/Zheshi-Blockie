// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/extensions/extensions.dart';
import 'package:blockie_app/models/app_bar_button_item.dart';
import 'package:blockie_app/widgets/basic_icon_button.dart';
import 'package:blockie_app/widgets/basic_popup_menu_button.dart';
import 'package:blockie_app/widgets/basic_popup_menu_item.dart';

class BasicAppBar extends StatelessWidget with PreferredSizeWidget {
  final String? title;
  final bool showsBackButton;
  final VoidCallback? backButtonOnTap;
  final Widget? avatar;
  final bool showsLogo;
  final List<AppBarButtonItem>? actionItems;

  BasicAppBar({
    Key? key,
    this.title,
    this.showsBackButton = true,
    this.backButtonOnTap,
    this.showsLogo = false,
    this.actionItems,
    this.avatar,
  }) : super(key: key);

  double get toolbarHeight => showsLogo ? 120 : 80;

  double get paddingTop => showsLogo ? 30 : 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget>? actions = actionItems?.map((item) {
      final button = BasicIconButton(
          assetName: item.assetName, size: 34, onTap: item.onTap);
      return (item.items ?? []).isEmpty
          ? button.paddingOnly(right: 13)
          : BasicPopupMenuButton(
              menuBuilder: () => Column(
                children: (item.items ?? [])
                    .asMap()
                    .entries
                    .map((it) => BasicPopupMenuItem(
                          item: it.value,
                          showsDivider: it.key != (item.items ?? []).length - 1,
                        ))
                    .toList(),
              ),
              pressType: PressType.singleClick,
              child: button,
            ).paddingOnly(right: 13);
    }).toList();
    final backButton = Visibility(
      visible: showsBackButton && Get.routing.previous.isNotEmpty,
      child: BasicIconButton(
        assetName: "images/app_bar/back.png",
        size: 34,
        onTap: () {
          if (backButtonOnTap != null) {
            backButtonOnTap?.call();
          } else {
            Get.back();
          }
        },
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
