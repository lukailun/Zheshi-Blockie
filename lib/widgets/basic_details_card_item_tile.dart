// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/data/models/basic_details_card_item.dart';
import 'package:blockie_app/extensions/extensions.dart';
import 'package:blockie_app/utils/clipboard_utils.dart';
import 'package:blockie_app/widgets/basic_icon_button.dart';
import 'package:blockie_app/widgets/message_toast.dart';
import 'ellipsized_text.dart';

class BasicDetailsCardItemTile extends StatelessWidget {
  final BasicDetailsCardItem item;

  const BasicDetailsCardItemTile({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(item.title)
            .textColor(const Color(0x80FFFFFF))
            .fontSize(12)
            .fontWeight(FontWeightCompat.regular),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              child: SizedBox(
                width: item.ellipsized ? 150 : null,
                child: item.ellipsized
                    ? EllipsizedText(
                        item.content,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeightCompat.mostThick,
                        ),
                        ellipsis: Ellipsis.middle,
                      )
                    : Text(
                        item.content,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      )
                        .textColor(Colors.white)
                        .fontSize(16)
                        .fontWeight(FontWeightCompat.mostThick),
              ),
            ),
            Visibility(
              visible: item.copyable,
              child: BasicIconButton(
                assetName: "assets/images/common/copy.png",
                size: 24,
                onTap: () {
                  final copySuccess =
                      ClipboardUtils.copyToClipboard(item.content);
                  MessageToast.showMessage(copySuccess ? '复制成功' : '复制失败');
                },
              ).paddingOnly(left: 10),
            ),
            Visibility(
              visible: (item.iconUrl ?? '').isNotEmpty,
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                child: CachedNetworkImage(
                  imageUrl: item.iconUrl ?? '',
                  width: 24,
                  height: 24,
                  fit: BoxFit.cover,
                ),
              ).paddingOnly(left: 10),
            ),
          ],
        ),
      ],
    ).paddingSymmetric(vertical: 7);
  }
}
