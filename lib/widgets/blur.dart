// Dart imports:
import 'dart:ui';

// Flutter imports:
import 'package:flutter/material.dart';

///blur it's [child]
///[blur] is the value of blur effect, higher the blur more the blur effect (default value = 5)
///[blurColor] is the color of blur effect (default value = Colors.white)
///[borderRadius] is the radius of the child to be blurred
///[colorOpacity] is the opacity of the blurColor (default value = 0.5)
///[alignment] is the alignment geometry of the overlay (default value = Alignment.center)
class Blur extends StatelessWidget {
  const Blur({
    Key? key,
    required this.child,
    this.blur = 5,
    this.blurColor = Colors.white,
    this.borderRadius,
    this.colorOpacity = 0.5,
    this.alignment = Alignment.center,
    this.blurOnTap,
  }) : super(key: key);

  final Widget child;
  final double blur;
  final Color blurColor;
  final BorderRadius? borderRadius;
  final double colorOpacity;
  final AlignmentGeometry alignment;
  final Function()? blurOnTap;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.zero,
      child: Stack(
        children: [
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
              child: GestureDetector(
                onTap: blurOnTap,
                child: Container(
                  decoration: BoxDecoration(
                    color: blurColor.withOpacity(colorOpacity),
                  ),
                  alignment: alignment,
                ),
              ),
            ),
          ),
          child,
        ],
      ),
    );
  }
}
