// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

extension WidgetOutlineExtension on Widget {
  Widget outlined({bool visible = true}) => Container(
        foregroundDecoration: visible
            ? const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("images/outline.png"),
                  centerSlice: Rect.fromLTRB(24, 24, 26, 26),
                ),
              )
            : null,
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          child: paddingAll(8),
        ),
      );
}
