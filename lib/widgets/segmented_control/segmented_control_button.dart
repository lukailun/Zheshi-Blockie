import 'package:blockie_app/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:blockie_app/models/app_theme_data.dart';

class SegmentedControlButton extends StatelessWidget {
  final String title;
  final bool isSelected;
  final GestureTapCallback? onTap;

  const SegmentedControlButton({
    Key? key,
    required this.title,
    required this.isSelected,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(title)
              .textColor(isSelected
                  ? AppThemeData.primaryColor
                  : const Color(0xFF8F8F8F))
              .fontSize(15)
              .fontWeight(FontWeightCompat.regular),
          const Expanded(child: SizedBox()),
          Visibility(
            visible: isSelected,
            child: Container(
              color: AppThemeData.primaryColor,
              width: 20,
              height: 1,
            ),
          ),
        ],
      ),
    );
  }
}
