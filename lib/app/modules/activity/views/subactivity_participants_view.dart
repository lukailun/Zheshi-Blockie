// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/data/models/app_theme_data.dart';
import 'package:blockie_app/extensions/extensions.dart';

class SubactivityParticipantsView extends StatelessWidget {
  final String title;
  final int numberOfParticipants;
  final List<String> avatarUrls;

  const SubactivityParticipantsView({
    super.key,
    required this.title,
    required this.numberOfParticipants,
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
              Text('（$numberOfParticipants）')
                  .textColor(Colors.white)
                  .fontSize(12)
                  .fontWeight(FontWeightCompat.bold),
            ],
          ).paddingOnly(bottom: 11),
          GridView.count(
            shrinkWrap: true,
            padding: const EdgeInsets.only(bottom: 59),
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
                  ).paddingAll(5),
                )
                .toList(),
          ),
        ],
      ),
    ).paddingOnly(top: 11, bottom: 14, left: 10, right: 10);
  }
}
