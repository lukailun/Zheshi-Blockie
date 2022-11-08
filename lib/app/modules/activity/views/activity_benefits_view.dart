// Flutter imports:
import 'package:blockie_app/models/app_theme_data.dart';
import 'package:blockie_app/widgets/basic_elevated_button.dart';
import 'package:blockie_app/widgets/basic_icon_button.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/extensions/extensions.dart';
import '../models/activity_step.dart';

class ActivityBenefitsView extends StatelessWidget {
  final String title;
  final ActivityStep step;
  final Function(ActivityStep)? onTap;

  const ActivityBenefitsView({
    super.key,
    required this.title,
    required this.step,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title)
            .textColor(AppThemeData.secondaryColor)
            .fontSize(18)
            .fontWeight(FontWeightCompat.bold)
            .paddingOnly(bottom: 26),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                'NFT&礼品：球迷凭证',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              )
                  .textColor(Colors.white)
                  .fontWeight(FontWeightCompat.mostThick)
                  .fontSize(14),
            ),
            GestureDetector(
              onTap: () {},
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text('详情')
                      .textColor(const Color(0x80FFFFFF))
                      .fontSize(14)
                      .paddingOnly(right: 2),
                  const BasicIconButton(
                      assetName: 'assets/images/activity/arrow.png', size: 22),
                ],
              ),
            ).paddingOnly(left: 10),
          ],
        ),
        Center(
          child: CachedNetworkImage(
            imageUrl: step.imageUrl ?? '',
            width: 185,
            height: 185,
            fit: BoxFit.contain,
          ),
        ).paddingAll(27),
        BasicElevatedButton(
          title: '2022-11-24 00：00：00 开启铸造',
          borderRadius: 8,
        ).paddingSymmetric(horizontal: 12),
      ],
    )
        .paddingOnly(top: 11, bottom: 24, left: 10, right: 10)
        .outlined()
        .paddingSymmetric(vertical: 14);
  }
}
