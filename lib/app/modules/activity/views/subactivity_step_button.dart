// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/extensions/extensions.dart';
import 'package:blockie_app/data/models/app_theme_data.dart';

class SubactivityStepButton extends StatelessWidget {
  final String title;
  final String? iconUrl;
  final bool isCompleted;
  final bool isEnabled;
  final Function()? onTap;

  const SubactivityStepButton({
    Key? key,
    required this.title,
    required this.iconUrl,
    required this.isCompleted,
    this.isEnabled = true,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isEnabled ? onTap : null,
      child: Container(
        height: 45,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: Colors.white.withOpacity(0.2),
            width: 1,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Opacity(
              opacity: (iconUrl ?? '').isNotEmpty ? 1 : 0,
              child: CachedNetworkImage(
                imageUrl: iconUrl ?? '',
                width: 20,
                height: 20,
                fit: BoxFit.contain,
              ),
            ),
            Text(title)
                .textColor(AppThemeData.primaryColor)
                .fontWeight(FontWeightCompat.regular)
                .fontSize(16)
                .paddingSymmetric(horizontal: 12),
            const Spacer(flex: 1),
            Visibility(
              visible: isCompleted,
              child: Image.asset(
                'assets/images/activity/done.png',
                width: 40,
                height: 40,
              ),
            ),
          ],
        ).paddingSymmetric(horizontal: 12),
      ),
    );
  }
}
