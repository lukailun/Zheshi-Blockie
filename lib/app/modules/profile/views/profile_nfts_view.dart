import 'dart:math';

import 'package:blockie_app/app/modules/profile/models/profile_nft.dart';
import 'package:blockie_app/app/modules/profile/views/profile_nft_view.dart';
import 'package:blockie_app/extensions/extensions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileNftsView extends StatelessWidget {
  final String title;
  final List<ProfileNft> nfts;
  final String defaultAssetName;
  final Function(String) nftOnTap;

  const ProfileNftsView({
    super.key,
    required this.title,
    required this.nfts,
    required this.defaultAssetName,
    required this.nftOnTap,
  });

  @override
  Widget build(BuildContext context) {
    const size = 80.0;
    const maxCount = 4;
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
        ),
        SizedBox(
          height: size,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              final nft = index < nfts.length ? nfts[index] : null;
              return ProfileNftView(
                nft: nft,
                size: size,
                nftOnTap: nftOnTap,
                defaultAssetName: defaultAssetName,
              );
            },
            separatorBuilder: (context, index) => const SizedBox(width: 22),
            itemCount: max(nfts.length, maxCount),
          ),
        ).paddingOnly(top: 11, bottom: 63),
      ],
    ).paddingSymmetric(horizontal: 22);
  }
}
