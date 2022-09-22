import 'package:blockie_app/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../common/app_theme_data.dart';

class BasicElevatedButton extends StatelessWidget {
  final String title;
  final GestureTapCallback? onTap;
  final double borderRadius;
  final bool showsShadow;
  final bool isEnabled;

  const BasicElevatedButton({
    Key? key,
    required this.title,
    this.borderRadius = 30,
    this.showsShadow = true,
    this.isEnabled = true,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isEnabled ? onTap : null,
      child: Container(
        decoration: BoxDecoration(
          color:
              isEnabled ? AppThemeData.primaryColor : AppThemeData.disabledColor,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(borderRadius),
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
              .textColor(Colors.white)
              .fontWeight(FontWeightCompat.semiBold)
              .fontSize(14),
        ).paddingSymmetric(horizontal: 20, vertical: 8),
      ),
    );
  }
}
