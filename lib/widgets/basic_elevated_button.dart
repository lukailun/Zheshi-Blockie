// Flutter imports:
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';

// Project imports:
import 'package:blockie_app/data/models/app_theme_data.dart';
import 'package:blockie_app/extensions/extensions.dart';

class BasicElevatedButton extends StatelessWidget {
  final String title;
  final GestureTapCallback? onTap;
  final Color backgroundColor;
  final List<Color>? backgroundColors;
  final List<double>? backgroundColorsStops;
  final Color disabledColor;
  final Color textColor;
  final Color loadingIndicatorColor;
  final double textFontSize;
  final double borderRadius;
  final bool showsBorder;
  final bool showsShadow;
  final bool isEnabled;
  final bool isLoading;
  final bool pointerIntercepting;
  final double paddingHorizontal;
  final double paddingVertical;

  const BasicElevatedButton({
    Key? key,
    required this.title,
    this.borderRadius = 30,
    this.backgroundColor = AppThemeData.primaryColor,
    this.backgroundColors,
    this.backgroundColorsStops,
    this.disabledColor = AppThemeData.disabledColor,
    this.textColor = Colors.white,
    this.loadingIndicatorColor = Colors.white,
    this.textFontSize = 14,
    this.showsBorder = true,
    this.showsShadow = true,
    this.isEnabled = true,
    this.isLoading = false,
    this.pointerIntercepting = false,
    this.paddingHorizontal = 20,
    this.paddingVertical = 8,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PointerInterceptor(
      intercepting: pointerIntercepting,
      child: GestureDetector(
        onTap: isEnabled ? onTap : null,
        child: Container(
          decoration: BoxDecoration(
            color: isEnabled ? backgroundColor : disabledColor,
            gradient: (backgroundColors ?? []).isNotEmpty
                ? LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: backgroundColors ?? [],
                    stops: backgroundColorsStops)
                : null,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(borderRadius),
            border: showsBorder
                ? Border.all(color: Colors.white.withOpacity(0.2), width: 1)
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
                      blurRadius: 5,
                      offset: Offset(5, 5),
                    ),
                  ]
                : null,
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Offstage(
                  offstage: !isLoading,
                  child: SizedBox(
                    width: 15,
                    height: 15,
                    child: CircularProgressIndicator(
                      color: loadingIndicatorColor,
                    ),
                  ).paddingOnly(right: 15),
                ),
                Expanded(
                  child: AutoSizeText(
                    title,
                    style: TextStyle(
                      color: textColor,
                      fontWeight: FontWeightCompat.semiBold,
                      decoration: TextDecoration.none,
                      fontSize: textFontSize,
                    ),
                    maxLines: 1,
                    minFontSize: 8,
                    maxFontSize: textFontSize,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ).paddingSymmetric(
              horizontal: paddingHorizontal, vertical: paddingVertical),
        ),
      ),
    );
  }
}
