// Flutter imports:
import 'package:blockie_app/app/modules/activities/models/activity.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/extensions/extensions.dart';
import 'package:blockie_app/models/app_theme_data.dart';

class ActivitiesItemView extends StatelessWidget {
  final Activity activity;
  final Function()? onTap;
  final Function()? issuerOnTap;

  const ActivitiesItemView({
    super.key,
    required this.activity,
    this.onTap,
    this.issuerOnTap,
  });

  @override
  Widget build(BuildContext context) {
    final brandView = GestureDetector(
      onTap: issuerOnTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(16)),
            child: CachedNetworkImage(
              imageUrl: activity.issuer?.avatarUrl ?? '',
              width: 32,
              height: 32,
              fit: BoxFit.contain,
            ),
          ),
          Flexible(
            child: Text(
              activity.issuer?.name ?? '',
              maxLines: 2,
              softWrap: true,
              overflow: TextOverflow.ellipsis,
            )
                .fontSize(12)
                .textColor(Colors.white)
                .paddingSymmetric(horizontal: 9),
          ),
          const SizedBox(width: 120),
        ],
      ).paddingSymmetric(vertical: 14),
    );
    final location = Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Visibility(
          child: Image.asset(
            'assets/images/activities/location.png',
            width: 10,
            height: 12,
            fit: BoxFit.contain,
          ).paddingOnly(right: 4),
        ),
        Flexible(
          child: Text(
            '上海 ·徐汇',
            overflow: TextOverflow.ellipsis,
          )
              .fontSize(12)
              .textColor(const Color(0x80FFFFFF))
              .paddingOnly(right: 4),
        ),
        const SizedBox(width: 120),
      ],
    );
    final time = Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Flexible(
          child: Text(
            '9月30日 周六 18:00',
            overflow: TextOverflow.ellipsis,
          )
              .fontSize(12)
              .textColor(const Color(0x80FFFFFF))
              .paddingOnly(right: 4),
        ),
        const SizedBox(width: 120),
      ],
    ).paddingOnly(top: 4);
    final title = Text(
      activity.name,
      maxLines: 100,
    ).fontSize(26).textColor(Colors.white).paddingSymmetric(vertical: 9);
    final benefits = Wrap(
      spacing: 11,
      runSpacing: 11,
      children: [
        SizedBox(
          height: 25,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                '可获权益',
              ).fontSize(12).textColor(AppThemeData.secondaryColor),
            ],
          ),
        ),
        Container(
          height: 25,
          decoration: const BoxDecoration(
              color: AppThemeData.secondaryColor,
              borderRadius: BorderRadius.all(Radius.circular(12.5))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'NFT',
              )
                  .fontSize(12)
                  .fontWeight(FontWeightCompat.bold)
                  .textColor(AppThemeData.primaryColor)
                  .paddingSymmetric(horizontal: 10),
            ],
          ),
        ),
        Container(
          height: 25,
          decoration: const BoxDecoration(
              color: AppThemeData.secondaryColor,
              borderRadius: BorderRadius.all(Radius.circular(12.5))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '500RMB',
              )
                  .fontSize(12)
                  .fontWeight(FontWeightCompat.bold)
                  .textColor(AppThemeData.primaryColor)
                  .paddingSymmetric(horizontal: 10),
            ],
          ),
        ),
        Container(
          height: 25,
          decoration: const BoxDecoration(
              color: AppThemeData.secondaryColor,
              borderRadius: BorderRadius.all(Radius.circular(12.5))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '实体礼品',
              )
                  .fontSize(12)
                  .fontWeight(FontWeightCompat.bold)
                  .textColor(AppThemeData.primaryColor)
                  .paddingSymmetric(horizontal: 10),
            ],
          ),
        ),
      ],
    ).paddingOnly(bottom: 34);
    final cover = CachedNetworkImage(
      imageUrl: activity.projects.first.coverUrl ?? '',
      width: 150,
      height: 150,
      fit: BoxFit.cover,
    );
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.translucent,
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              brandView,
              location,
              time,
              title,
              benefits,
            ],
          ).paddingSymmetric(horizontal: 20).outlined().paddingOnly(top: 47),
          Positioned(
            width: 150,
            height: 150,
            right: 20,
            top: 0,
            child: cover,
          ),
        ],
      ),
    );
  }
}
