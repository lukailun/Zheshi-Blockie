// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';

// Project imports:
import 'package:blockie_app/data/models/app_bar_button_item.dart';
import 'package:blockie_app/data/models/app_theme_data.dart';
import 'package:blockie_app/extensions/extensions.dart';

class BasicPopupMenuItem extends StatelessWidget {
  final AppBarButtonItem item;
  final bool showsDivider;
  final bool pointerIntercepting;

  const BasicPopupMenuItem({
    Key? key,
    required this.item,
    this.showsDivider = true,
    this.pointerIntercepting = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PointerInterceptor(
      intercepting: pointerIntercepting,
      child: GestureDetector(
        onTap: () => item.onTap?.call(), // Image tapped
        behavior: HitTestBehavior.translucent,
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
