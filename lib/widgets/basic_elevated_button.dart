import 'package:blockie_app/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';

import '../models/app_theme_data.dart';

class BasicElevatedButton extends StatelessWidget {
  final String title;
  final GestureTapCallback? onTap;
  final Color backgroundColor;
  final Color textColor;
  final double borderRadius;
  final bool showsBorder;
  final bool showsShadow;
  final bool isEnabled;

  const BasicElevatedButton({
    Key? key,
    required this.title,
    this.borderRadius = 30,
    this.backgroundColor = AppThemeData.primaryColor,
    this.textColor = Colors.white,
    this.showsBorder = true,
    this.showsShadow = true,
    this.isEnabled = true,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PointerInterceptor(
      child: GestureDetector(
        onTap: isEnabled ? onTap : null,
        child: Container(
          decoration: BoxDecoration(
            color: isEnabled ? backgroundColor : AppThemeData.disabledColor,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(borderRadius),
            border: showsBorder
                ? Border.all(
                    color: Colors.white.withOpacity(0.2),
                    width: 1,
                  )
                : null,
            boxShadow: showsShadow
                ? const [
                    BoxShadow(
                      color: Color(0x1AFFFFFF),
                      spreadRadius: 0,
                      blurRadius: 0,
                      offset: Offset(-1, -1),
                    ),
                    BoxShadow(
                      color: Color(0xFF000000),
                      spreadRadius: 0,
                      blurRadius: 2,
                      offset: Offset(1, 1),
                    ),
                  ]
                : null,
          ),
          child: Center(
            child: Text(title)
                .withoutUnderLine()
                .textColor(textColor)
                .fontWeight(FontWeightCompat.semiBold)
                .fontSize(14),
          ).paddingSymmetric(horizontal: 20, vertical: 8),
        ),
      ),
    );
  }
}
