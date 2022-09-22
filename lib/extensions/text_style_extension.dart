import 'package:flutter/material.dart';

extension TextStyleExtension on TextStyle {
  TextStyle get mostThick => TextStyle(
      fontSize: fontSize, fontFamily: fontFamily, fontWeight: FontWeight.w900);

  TextStyle get extraBold => TextStyle(
      fontSize: fontSize, fontFamily: fontFamily, fontWeight: FontWeight.w800);

  TextStyle get bold => TextStyle(
      fontSize: fontSize, fontFamily: fontFamily, fontWeight: FontWeight.w700);

  TextStyle get semiBold => TextStyle(
      fontSize: fontSize, fontFamily: fontFamily, fontWeight: FontWeight.w600);

  TextStyle get medium => TextStyle(
      fontSize: fontSize, fontFamily: fontFamily, fontWeight: FontWeight.w500);

  TextStyle get regular => TextStyle(
      fontSize: fontSize, fontFamily: fontFamily, fontWeight: FontWeight.w400);

  TextStyle get light => TextStyle(
      fontSize: fontSize, fontFamily: fontFamily, fontWeight: FontWeight.w300);

  TextStyle get extraLight => TextStyle(
      fontSize: fontSize, fontFamily: fontFamily, fontWeight: FontWeight.w200);

  TextStyle get thin => TextStyle(
      fontSize: fontSize, fontFamily: fontFamily, fontWeight: FontWeight.w100);
}
