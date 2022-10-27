import 'package:blockie_app/app/modules/profile/models/profile_nft.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ProfileNftView extends StatelessWidget {
  final ProfileNft? nft;
  final double size;
  final String defaultAssetName;
  final Function(String) nftOnTap;

  const ProfileNftView({
    super.key,
    required this.nft,
    required this.size,
    required this.defaultAssetName,
    required this.nftOnTap,
  });

  @override
  Widget build(BuildContext context) {
    if (nft == null) {
      return SizedBox(
        width: size,
        height: size,
        child: ClipRRect(
          // borderRadius: BorderRadius.all(Radius.circular(size / 2)),
          child: Image.asset(
            defaultAssetName,
            width: size,
            height: size,
            fit: BoxFit.cover,
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
          borderRadius: BorderRadius.all(Radius.circular(size / 2)),
          child: CachedNetworkImage(
            imageUrl: nft!.coverUrl,
            fit: BoxFit.cover,
            width: size,
            height: size,
          ),
        ),
      ),
    );
  }
}
