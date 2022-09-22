import 'package:flutter/material.dart';

extension WidgetOutlineExtension on Widget {
  Widget outlined() => Container(
        foregroundDecoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/outline.png"),
            centerSlice: Rect.fromLTRB(24, 24, 26, 26),
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: this,
        ),
      );
}
