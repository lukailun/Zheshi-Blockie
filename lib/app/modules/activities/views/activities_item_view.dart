// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/app/modules/activities/models/activity.dart';
import 'package:blockie_app/data/models/app_theme_data.dart';
import 'package:blockie_app/extensions/extensions.dart';

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
              imageUrl: activity.issuer.logoUrl ?? '',
              width: 32,
              height: 32,
              fit: BoxFit.contain,
            ),
          ),
          Flexible(
            child: Text(
              activity.issuer.title,
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
      ).paddingOnly(top: 18, bottom: 14),
    );
    final location = Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Visibility(
          visible: !activity.isOnline && activity.location.isNotEmpty,
          child: Image.asset(
            'assets/images/activities/location.png',
            width: 10,
            height: 12,
            fit: BoxFit.contain,
          ).paddingOnly(right: 4),
        ),
        Flexible(
          child: Text(
            activity.location,
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
            activity.startedTime ?? '',
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
      style: const TextStyle(fontWeight: FontWeight.bold),
    ).fontSize(26).textColor(Colors.white).paddingSymmetric(vertical: 9);
    final benefits = Visibility(
      visible: activity.benefits.isNotEmpty,
      child: Wrap(
        spacing: 11,
        runSpacing: 11,
        children: [
              Container(
                height: 25,
                color: Colors.transparent,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      '可获奖励',
                    ).fontSize(12).textColor(AppThemeData.secondaryColor),
                  ],
                ),
              ),
            ] +
            activity.benefits.map((it) {
              return Container(
                height: 25,
                decoration: const BoxDecoration(
                    color: AppThemeData.secondaryColor,
                    borderRadius: BorderRadius.all(Radius.circular(12.5))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      it,
                    )
                        .fontSize(12)
                        .fontWeight(FontWeightCompat.bold)
                        .textColor(AppThemeData.primaryColor)
                        .paddingSymmetric(horizontal: 10),
                  ],
                ),
              );
            }).toList(),
      ).paddingOnly(top: 3, bottom: 30),
    );
    final cover = Visibility(
      visible: (activity.coverUrl ?? '').isNotEmpty,
      child: CachedNetworkImage(
        imageUrl: activity.coverUrl ?? '',
        width: 150,
        height: 150,
        fit: BoxFit.cover,
      ),
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
          )
              .paddingSymmetric(horizontal: 20)
              .outlined()
              .paddingOnly(top: (activity.coverUrl ?? '').isNotEmpty ? 47 : 0),
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
