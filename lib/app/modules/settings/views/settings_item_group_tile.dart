import 'package:blockie_app/extensions/extensions.dart';
import 'package:blockie_app/app/modules/settings/views/settings_item_tile.dart';
import 'package:flutter/material.dart';

import '../models/settings_item_groups.dart';

class SettingsItemGroupTile extends StatelessWidget {
  final SettingsItemGroup group;

  const SettingsItemGroupTile({
    Key? key,
    required this.group,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final itemTiles =
        group.items.map((item) => SettingsItemTile(item: item)).toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
            const SizedBox(height: 20),
            Text(group.title)
                .textColor(const Color(0x80FFFFFF))
                .fontWeight(FontWeightCompat.semiBold)
                .fontSize(14),
          ] +
          itemTiles,
    );
  }
}
