// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

extension WidgetOutlineExtension on Widget {
  Widget outlined({
    bool visible = true,
  }) =>
      Container(
        foregroundDecoration: visible
            ? const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("images/common/outline.png"),
                  centerSlice: Rect.fromLTRB(26, 26, 28, 28),
                ),
              )
            : null,
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          child: this,
        ).paddingAll(3),
      );
}
