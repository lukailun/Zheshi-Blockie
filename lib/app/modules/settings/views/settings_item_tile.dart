// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/app/modules/settings/models/settings_item_groups.dart';
import 'package:blockie_app/extensions/extensions.dart';
import 'package:blockie_app/widgets/basic_icon_button.dart';

class SettingsItemTile extends StatelessWidget {
  final SettingsItem item;

  const SettingsItemTile({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 62,
      width: double.infinity,
      child: GestureDetector(
        onTap: item.onTap,
        behavior: HitTestBehavior.translucent,
        child: Center(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(item.title)
                  .textColor(Colors.white)
                  .fontWeight(FontWeightCompat.semiBold)
                  .fontSize(16)
                  .paddingOnly(right: 18),
              const Expanded(child: SizedBox()),
              Offstage(
                offstage: (item.content ?? '').isEmpty,
                child: Text(item.content ?? '')
                    .textColor(Colors.white)
                    .fontWeight(FontWeightCompat.semiBold)
                    .fontSize(16),
              ),
              Offstage(
                offstage: !item.arrowIsVisible,
                child: const BasicIconButton(
                  assetName: 'images/settings/arrow.png',
                  size: 22,
                ),
              ),
            ],
          ).paddingSymmetric(horizontal: 18),
        ),
      ),
    ).outlined().paddingSymmetric(vertical: 10);
  }
}
