// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/data/models/basic_details_card_item.dart';
import 'package:blockie_app/extensions/extensions.dart';
import 'package:blockie_app/widgets/basic_details_card_item_tile.dart';

class BasicDetailsCard extends StatelessWidget {
  final List<BasicDetailsCardItem> items;
  final double paddingHorizontal;
  final double paddingVertical;

  const BasicDetailsCard({
    Key? key,
    required this.items,
    this.paddingHorizontal = 22,
    this.paddingVertical = 18,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items.map((it) => BasicDetailsCardItemTile(item: it)).toList(),
    )
        .paddingSymmetric(
            horizontal: paddingHorizontal, vertical: paddingVertical)
        .outlined();
  }
}
