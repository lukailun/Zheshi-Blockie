import 'package:flutter/material.dart';
import 'package:get/get.dart';

extension WidgetOutlineExtension on Widget {
  Widget outlined() => Container(
        foregroundDecoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/outline.png"),
            centerSlice: Rect.fromLTRB(24, 24, 26, 26),
          ),
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          child: paddingAll(8),
        ),
      );
}
