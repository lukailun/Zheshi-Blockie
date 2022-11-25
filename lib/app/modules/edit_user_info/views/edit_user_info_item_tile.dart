// Flutter imports:
import 'package:blockie_app/app/modules/edit_user_info/models/edit_user_info_item.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/extensions/extensions.dart';
import 'package:blockie_app/widgets/basic_icon_button.dart';

class EditUserInfoItemTile extends StatelessWidget {
  final EditUserInfoItem item;

  const EditUserInfoItemTile({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 28,
      width: double.infinity,
      child: GestureDetector(
        onTap: item.onTap,
        behavior: HitTestBehavior.translucent,
        child: Center(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(item.title)
                  .textColor(const Color(0xB2FFFFFF))
                  .fontWeight(FontWeightCompat.regular)
                  .fontSize(14)
                  .paddingOnly(right: 13),
              const Spacer(flex: 1),
              Visibility(
                visible: (item.content ?? '').isNotEmpty,
                replacement: Text(item.placeholder ?? '')
                    .textColor(const Color(0xB2FFFFFF))
                    .fontWeight(FontWeightCompat.regular)
                    .fontSize(14),
                child: Text(item.content ?? '')
                    .textColor(Colors.white)
                    .fontWeight(FontWeightCompat.regular)
                    .fontSize(14),
              ).paddingOnly(right: 13),
              const BasicIconButton(
                assetName: 'assets/images/settings/arrow.png',
                size: 22,
              ),
            ],
          ).paddingSymmetric(horizontal: 22),
        ),
      ),
    );
  }
}
