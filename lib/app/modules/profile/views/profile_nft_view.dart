// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:cached_network_image/cached_network_image.dart';

// Project imports:
import 'package:blockie_app/app/modules/profile/models/profile_nft.dart';

class ProfileNftView extends StatelessWidget {
  final ProfileNft? nft;
  final double size;
  final String defaultAssetName;
  final bool isCircular;
  final Function(String) nftOnTap;

  const ProfileNftView({
    super.key,
    required this.nft,
    required this.size,
    required this.defaultAssetName,
    required this.isCircular,
    required this.nftOnTap,
  });

  @override
  Widget build(BuildContext context) {
    if (nft == null) {
      return SizedBox(
        width: size,
        height: size,
        child: ClipRRect(
          child: Image.asset(
            defaultAssetName,
            width: size,
            height: size,
            fit: BoxFit.contain,
          ),
        ),
      );
    }
    return GestureDetector(
      onTap: () => nftOnTap(nft!.id),
      child: SizedBox(
        width: size,
        height: size,
        child: ClipRRect(
          borderRadius:
              BorderRadius.all(Radius.circular(isCircular ? size / 2 : 0)),
          child: CachedNetworkImage(
            imageUrl: nft!.coverUrl,
            fit: BoxFit.contain,
            width: size,
            height: size,
          ),
        ),
      ),
    );
  }
}
