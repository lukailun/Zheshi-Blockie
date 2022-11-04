// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/app/modules/profile/models/profile_label.dart';
import 'package:blockie_app/extensions/extensions.dart';

class LabelView extends StatelessWidget {
  final ProfileLabel label;

  const LabelView({
    super.key,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/profile/label_background.png"),
            ),
          ),
          child: Center(
            child: CachedNetworkImage(
              imageUrl: label.iconUrl,
              width: 20,
              height: 20,
              fit: BoxFit.contain,
            ),
          ),
        ),
        SizedBox(
          height: 20,
          child: Center(
            child: Text(label.name).fontSize(10).textColor(Colors.white),
          ),
        ),
      ],
    ).paddingSymmetric(horizontal: 5.5);
  }
}
