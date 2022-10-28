// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:pointer_interceptor/pointer_interceptor.dart';

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
        child: SizedBox(
          width: size,
          height: size,
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
