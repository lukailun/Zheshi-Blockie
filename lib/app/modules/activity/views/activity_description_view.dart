// Flutter imports:
import 'package:blockie_app/models/app_theme_data.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/extensions/extensions.dart';

class ActivityDescriptionView extends StatelessWidget {
  final String title;
  final String description;

  const ActivityDescriptionView({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title)
              .textColor(AppThemeData.secondaryColor)
              .fontSize(18)
              .fontWeight(FontWeightCompat.bold)
              .paddingOnly(bottom: 11),
          Text(description.formatted)
              .textColor(const Color(0xFFF1F1F1))
              .fontSize(12),
        ],
      ),
    )
        .paddingOnly(top: 11, bottom: 24, left: 10, right: 10)
        .outlined()
        .paddingSymmetric(vertical: 14);
  }
}
