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
        boxShadow: [
          BoxShadow(
            color: Color(0x1AFFFFFF),
            spreadRadius: 0,
            blurRadius: 1,
            offset: Offset(1, 1),
          ),
          BoxShadow(
            color: Color(0xFF000000),
            spreadRadius: 0,
            blurRadius: 2,
            offset: Offset(1, 1),
          ),
        ],
      ),
      child: Text(tag)
          .textColor(Colors.white)
          .fontSize(12)
          .paddingSymmetric(horizontal: 10, vertical: 6),
    );
  }
}
