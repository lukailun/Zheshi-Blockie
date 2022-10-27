// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/extensions/extensions.dart';

class TicketCheckingItemView extends StatelessWidget {
  const TicketCheckingItemView({super.key});

  @override
  Widget build(BuildContext context) {
    final header = Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          child: CachedNetworkImage(
            imageUrl: '',
            width: 80,
            height: 80,
            fit: BoxFit.cover,
          ),
        ),
        Text('xxxxx').textColor(Colors.black).fontSize(16).paddingAll(13),
      ],
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        header,
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 15),
          itemBuilder: (context, index) {
            return TicketCheckingItemPrizeView();
          },
          separatorBuilder: (context, index) =>
              const Divider(color: Color(0x1AFFFFFF), thickness: 1),
          itemCount: 10,
        ),
      ],
    ).outlined();
  }
}

class TicketCheckingItemPrizeView extends StatelessWidget {
  const TicketCheckingItemPrizeView({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 34,
      child: Row(
        children: [
          Expanded(
            child: Text('纪念水').textColor(Colors.black).fontSize(14),
          ),
          Expanded(
            child: Text(
              '52/100',
              textAlign: TextAlign.center,
            ).textColor(Colors.black).fontSize(14),
          ),
          Expanded(
            child: Row(
              children: [
                const Spacer(flex: 1),
                const Text('未核销')
                    .fontSize(14)
                    .textColor(const Color(0xFFFF8F1F)),
                Image.asset(
                  'images/projects_management/unselected.png',
                  width: 20,
                  height: 20,
                  fit: BoxFit.contain,
                ).paddingOnly(left: 5),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
