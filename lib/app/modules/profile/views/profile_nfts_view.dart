// Dart imports:
import 'dart:math';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/app/modules/profile/models/profile_nft.dart';
import 'package:blockie_app/app/modules/profile/views/profile_nft_view.dart';
import 'package:blockie_app/extensions/extensions.dart';
import 'package:blockie_app/data/models/platform_info.dart';

class ProfileNftsView extends StatelessWidget {
  final String title;
  final List<ProfileNft> nfts;
  final String defaultAssetName;
  final bool isCircular;
  final Function(String)? nftOnTap;

  const ProfileNftsView({
    super.key,
    required this.title,
    required this.nfts,
    required this.defaultAssetName,
    required this.isCircular,
    this.nftOnTap,
  });

  @override
  Widget build(BuildContext context) {
    const maxCount = 4;
    final width = PlatformInfo.isWeb ? min(Get.width, 450) : Get.width;
    final size = (width - 22 * maxCount) / 3.63;
    return Column(
      children: [
        Row(
          children: [
            Text(title).fontSize(15).textColor(const Color(0xCCFFFFFF)),
            const Spacer(flex: 1),
            Text('共 ${nfts.length} 个')
                .fontSize(15)
                .textColor(const Color(0xCCFFFFFF)),
          ],
        ).paddingSymmetric(horizontal: 22),
        SizedBox(
          height: size,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 22),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              final nft = index < nfts.length ? nfts[index] : null;
              return ProfileNftView(
                nft: nft,
                size: size,
                nftOnTap: nftOnTap,
                isCircular: isCircular,
                defaultAssetName: defaultAssetName,
              );
            },
            separatorBuilder: (context, index) => const SizedBox(width: 22),
            itemCount: max(nfts.length, maxCount),
          ),
        ).paddingOnly(top: 17, bottom: 58),
      ],
    );
  }
}
