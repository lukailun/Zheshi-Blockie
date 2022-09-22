import 'dart:ui';
import 'package:flutter/material.dart';

class ScreenBoundary extends StatelessWidget {
  ScreenBoundary({Key? key, required this.body, this.padding=20}) : super(key: key);
  Widget body;
  double padding;
  @override
  Widget build(BuildContext context) {
    return Material(
        color: const Color(0xfff0f2f5),
        child: Align(
            alignment: Alignment.topCenter,
            child: Container( // display area
              width: 450, // max width
              height: double.infinity,
              color: const Color(0xff3C63F8),
              padding: EdgeInsets.symmetric(horizontal: padding),
              child: body,
            )
        )
    );
  }
}