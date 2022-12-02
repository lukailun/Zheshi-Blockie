// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/app/modules/edit_user_info/models/edit_user_info_item.dart';
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
      width: double.infinity,
      child: GestureDetector(
        onTap: item.onTap,
        behavior: HitTestBehavior.translucent,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(item.title)
                      .textColor(const Color(0xB2FFFFFF))
                      .fontWeight(FontWeightCompat.regular)
                      .fontSize(14)
                      .paddingOnly(right: 13),
                  Expanded(
                    child: Visibility(
                      visible: (item.content ?? '').isNotEmpty,
                      replacement: Text(item.placeholder ?? '')
                          .textColor(const Color(0xB2FFFFFF))
                          .fontWeight(FontWeightCompat.regular)
                          .fontSize(14)
                          .textAlignment(TextAlign.right),
                      child: Text(
                        item.content ?? '',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      )
                          .textColor(Colors.white)
                          .fontWeight(FontWeightCompat.regular)
                          .fontSize(14)
                          .textAlignment(TextAlign.right),
                    ).paddingOnly(right: 13),
                  ),
                  const BasicIconButton(
                    assetName: 'assets/images/common/arrow.png',
                    size: 22,
                  ),
                ],
              ),
            ),
            const Divider(color: Color(0x33FFFFFF), thickness: 1),
          ],
        ).paddingSymmetric(horizontal: 22),
      ),
    );
  }
}
