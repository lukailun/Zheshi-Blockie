// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';

// Project imports:
import 'package:blockie_app/extensions/extensions.dart';
import '../models/app_bar_button_item.dart';
import '../models/app_theme_data.dart';
import 'basic_popup_menu_button.dart';

class BasicPopupMenuItem extends StatelessWidget {
  final AppBarButtonItem item;
  final BasicPopupMenuButtonController controller;
  final bool showsDivider;

  const BasicPopupMenuItem({
    Key? key,
    required this.item,
    required this.controller,
    this.showsDivider = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PointerInterceptor(
      child: GestureDetector(
        onTap: () {
          controller.hideMenu();
          if (item.onTap != null) {
            item.onTap!();
          }
        }, // Image tapped
        child: Container(
          color: Colors.transparent,
          height: 40,
          width: double.infinity,
          child: Column(
            children: [
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      item.assetName,
                      width: 16,
                      height: 16,
                      fit: BoxFit.contain,
                      color: AppThemeData.primaryColor,
                    ).paddingOnly(right: 5),
                    Text(item.title ?? '')
                        .fontSize(16)
                        .fontWeight(FontWeightCompat.regular)
                        .textColor(AppThemeData.primaryColor),
                  ],
                ),
              ),
              if (showsDivider)
                const Divider(
                  color: Color(0xFFE7E7E7),
                  height: 1,
                ),
            ],
          ).paddingSymmetric(horizontal: 17),
        ),
      ),
    );
  }
}
