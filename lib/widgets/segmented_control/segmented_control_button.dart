// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:blockie_app/extensions/extensions.dart';
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
              .fontWeight(FontWeightCompat.semiBold),
          const Expanded(child: SizedBox()),
          Visibility(
            visible: isSelected,
            child: Image.asset(
              'assets/images/common/segmented_control_selected.png',
              width: 20,
              height: 1,
            ),
          ),
        ],
      ),
    );
  }
}
