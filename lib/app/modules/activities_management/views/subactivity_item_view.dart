// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/app/modules/activities_management/models/subactivity.dart';
import 'package:blockie_app/data/models/app_theme_data.dart';
import 'package:blockie_app/data/models/issuer.dart';
import 'package:blockie_app/extensions/extensions.dart';

class SubactivityItemView extends StatelessWidget {
  final Subactivity subactivity;
  final Issuer? issuer;
  final Function()? onTap;
  final Function()? issuerOnTap;

  const SubactivityItemView({
    super.key,
    required this.subactivity,
    this.issuer,
    this.onTap,
    this.issuerOnTap,
  });

  @override
  Widget build(BuildContext context) {
    final coverUrl = subactivity.coverUrl ?? '';
    final cover = AspectRatio(
      aspectRatio: 332.0 / 250.0,
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
        child: coverUrl.isNotEmpty
            ? CachedNetworkImage(
                imageUrl: subactivity.coverUrl ?? '',
                fit: BoxFit.cover,
              )
            : const SizedBox(),
      ),
    ).paddingOnly(bottom: 16);
    final title = Text(subactivity.name)
        .textColor(Colors.white)
        .fontSize(21)
        .paddingOnly(left: 16, right: 16, bottom: 16);
    final summary = Visibility(
      visible: (subactivity.summary ?? '').isNotEmpty,
      child: Text(
        subactivity.summary ?? '',
        maxLines: 2,
      )
          .textColor(const Color(0xB3FFFFFF))
          .fontSize(14)
          .paddingOnly(left: 16, right: 16, bottom: 16),
    );
    final brandInfo = Visibility(
      visible: issuer != null,
      child: GestureDetector(
        onTap: issuerOnTap,
        child: Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              child: CachedNetworkImage(
                imageUrl: issuer?.logoUrl ?? '',
                width: 40,
                height: 40,
              ),
            ),
            Text(issuer?.title ?? '')
                .fontSize(14)
                .textColor(const Color(0xB3FFFFFF))
                .paddingOnly(left: 7),
            const Spacer(flex: 1),
            Text('共发行 ${subactivity.totalAmount}')
                .fontSize(14)
                .textColor(const Color(0xB3FFFFFF))
                .paddingOnly(left: 7),
          ],
        ),
      ).paddingOnly(left: 16, right: 16, bottom: 16),
    );
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.translucent,
      child: Container(
        color: AppThemeData.primaryColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            cover,
            title,
            summary,
            brandInfo,
          ],
        ),
      ),
    ).outlined().paddingOnly(bottom: 11);
  }
}
