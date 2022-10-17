// Flutter imports:
import 'package:flutter/material.dart';

class AppBarButtonItem {
  final String? title;
  final String assetName;

  /// [onTap] only works when [items] is null.
  final GestureTapCallback? onTap;

  /// It shows popup menu when [items] is not empty.
  final List<AppBarButtonItem>? items;

  AppBarButtonItem({
    required this.assetName,
    this.title,
    this.onTap,
    this.items,
  });
}
