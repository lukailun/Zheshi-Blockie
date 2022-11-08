// Flutter imports:
import 'package:blockie_app/models/app_theme_data.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/extensions/extensions.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ActivityParticipantsView extends StatelessWidget {
  final String title;
  final List<String> avatarUrls;

  const ActivityParticipantsView({
    super.key,
    required this.title,
    required this.avatarUrls,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(title)
                  .textColor(AppThemeData.secondaryColor)
                  .fontSize(18)
                  .fontWeight(FontWeightCompat.bold),
              Text('（${avatarUrls.length}）')
                  .textColor(Colors.white)
                  .fontSize(12)
                  .fontWeight(FontWeightCompat.bold),
            ],
          ).paddingOnly(bottom: 11),
          GridView.count(
            shrinkWrap: true,
            padding: const EdgeInsets.only(top: 12, bottom: 59),
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 8,
            children: avatarUrls
                .map(
                  (it) => ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(100)),
                    child: CachedNetworkImage(
                      imageUrl: it,
                      fit: BoxFit.cover,
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    ).paddingOnly(top: 11, bottom: 24, left: 10, right: 10);
  }
}
