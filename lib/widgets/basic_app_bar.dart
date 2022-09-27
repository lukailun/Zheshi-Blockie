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

class BasicAppBar extends StatelessWidget with PreferredSizeWidget {
  final String? title;
  final bool showsBackButton;
  final List<AppBarButtonItem>? actionItems;
  final AppBarButtonStyle buttonStyle;

  BasicAppBar({
    Key? key,
    this.title,
    this.showsBackButton = true,
    this.actionItems,
    this.buttonStyle = AppBarButtonStyle.elevated,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final popupMenuButtonController = BasicPopupMenuButtonController();
    final List<Widget>? actions = actionItems?.map((item) {
      final button = buttonStyle == AppBarButtonStyle.elevated
          ? BasicIconButton(
              assetName: item.assetName, size: 34, onTap: item.onTap)
          : BasicFlatButton(
              assetName: item.assetName, size: 34, onTap: item.onTap);
      return (item.items ?? []).isEmpty
          ? button.paddingOnly(right: 13)
          : BasicPopupMenuButton(
              controller: popupMenuButtonController,
              menuBuilder: () => Column(
                children: (item.items ?? [])
                    .asMap()
                    .entries
                    .map((it) => BasicPopupMenuItem(
                          item: it.value,
                          controller: popupMenuButtonController,
                          showsDivider: it.key != (item.items ?? []).length - 1,
                        ))
                    .toList(),
              ),
              pressType: PressType.singleClick,
              child: button,
            ).paddingOnly(right: 13);
    }).toList();
    return AppBar(
      leading: Visibility(
        visible: showsBackButton,
        child: BasicFlatButton(
          assetName: "images/app_bar/back.png",
          size: 34,
          onTap: () => Get.back(),
        ).paddingOnly(left: 22),
      ),
      leadingWidth: 56,
      actions: actions?..add(const SizedBox(width: 9)),
      backgroundColor: Colors.transparent,
      centerTitle: true,
      toolbarHeight: 80,
      title: Text(
        title ?? '',
        maxLines: 2,
        textAlign: TextAlign.center,
      ).textColor(Colors.white).fontSize(20).fontWeight(FontWeightCompat.bold),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(80);
}
