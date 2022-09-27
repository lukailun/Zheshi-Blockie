import 'package:flutter/material.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';
import '../models/app_theme_data.dart';

class BasicFlatButton extends StatelessWidget {
  final String assetName;
  final double size;
  final GestureTapCallback? onTap;

  const BasicFlatButton({
    Key? key,
    required this.assetName,
    required this.size,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PointerInterceptor(
      child: GestureDetector(
        onTap: onTap, // Image tapped
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white.withOpacity(0.4),
          ),
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppThemeData.primaryColor.withOpacity(0.5),
                  border: Border.all(color: Colors.white.withOpacity(0.4)),
                ),
              ),
              Center(
                child: Image.asset(assetName),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
