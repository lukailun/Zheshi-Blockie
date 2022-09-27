import 'package:flutter/material.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';

import '../models/app_theme_data.dart';

class BasicIconButton extends StatelessWidget {
  final String assetName;
  final double size;
  final GestureTapCallback? onTap;

  const BasicIconButton({
    Key? key,
    required this.assetName,
    required this.size,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PointerInterceptor(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: size,
          height: size,
          decoration: const BoxDecoration(
            color: AppThemeData.primaryColor,
            shape: BoxShape.circle,
            boxShadow: [
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
            ],
          ),
          child: Image.asset(
            assetName,
            width: size,
            height: size,
          ),
        ),
      ),
    );
  }
}
