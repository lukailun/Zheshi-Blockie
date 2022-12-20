// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/app/modules/airdrop_nft/models/activity.dart';
import 'package:blockie_app/extensions/extensions.dart';

class AirdropNftItemView extends StatelessWidget {
  final Activity activity;
  final Function()? activityOnTap;

  const AirdropNftItemView({
    super.key,
    required this.activity,
    this.activityOnTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: activity.hasMinted ? null : () => activityOnTap?.call(),
      behavior: HitTestBehavior.translucent,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            child: CachedNetworkImage(
              imageUrl: activity.coverUrl,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(activity.name).textColor(Colors.white).fontSize(16),
              const SizedBox(height: 10),
              Text(activity.hasMinted ? '已空投' : '未空投')
                  .textColor(activity.hasMinted
                      ? const Color(0xFF888888)
                      : const Color(0xFFFF8F1F))
                  .fontSize(14),
            ],
          ).paddingAll(13),
          const Spacer(flex: 1),
          Opacity(
            opacity: activity.hasMinted ? 0 : 1,
            child: Image.asset(
              activity.isSelected
                  ? 'assets/images/projects_management/selected.png'
                  : 'assets/images/projects_management/unselected.png',
              width: 20,
              height: 20,
              fit: BoxFit.contain,
            ),
          ).paddingOnly(right: 24),
        ],
      ),
    ).outlined();
  }
}
