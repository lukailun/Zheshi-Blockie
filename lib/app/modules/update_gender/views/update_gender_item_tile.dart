// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/extensions/extensions.dart';
import 'package:blockie_app/widgets/basic_icon_button.dart';

class UpdateGenderItemTile extends StatelessWidget {
  final String title;
  final bool isSelected;
  final Function()? onTap;

  const UpdateGenderItemTile({
    Key? key,
    required this.title,
    this.isSelected = false,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.translucent,
        child: Center(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(title)
                  .textColor(Colors.white)
                  .fontWeight(FontWeightCompat.regular)
                  .fontSize(16),
              const Spacer(flex: 1),
              BasicIconButton(
                assetName: isSelected
                    ? 'assets/images/common/selected.png'
                    : 'assets/images/common/unselected.png',
                size: 22,
              ),
            ],
          ),
        ).paddingSymmetric(horizontal: 22),
      ),
    );
  }
}
