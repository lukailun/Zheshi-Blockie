// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/extensions/extensions.dart';

class TagView extends StatelessWidget {
  final String tag;

  const TagView({
    super.key,
    required this.tag,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF545454),
            Color(0x00333333),
          ],
        ),
        borderRadius: BorderRadius.all(Radius.circular(13.5)),
      ),
      child: Text(tag)
          .textColor(Colors.white)
          .fontSize(12)
          .paddingSymmetric(horizontal: 10, vertical: 6),
    );
  }
}
