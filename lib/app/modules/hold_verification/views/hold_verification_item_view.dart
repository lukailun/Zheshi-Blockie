// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/app/modules/hold_verification/models/nft.dart';
import 'package:blockie_app/extensions/extensions.dart';

class HoldVerificationItemView extends StatelessWidget {
  final Nft nft;

  const HoldVerificationItemView({
    super.key,
    required this.nft,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          child: CachedNetworkImage(
            imageUrl: nft.activity.coverUrl,
            width: 80,
            height: 80,
            fit: BoxFit.cover,
          ),
        ),
        Text(nft.activity.name)
            .textColor(Colors.white)
            .fontSize(16)
            .paddingAll(13),
      ],
    ).outlined();
  }
}
