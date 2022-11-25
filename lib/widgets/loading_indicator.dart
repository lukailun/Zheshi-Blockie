// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/data/models/app_theme_data.dart';

extension GetDialogExtension on GetInterface {
  void loadingIndicatorDialog() {
    Get.dialog(
      const LoadingIndicator(),
      barrierColor: AppThemeData.barrierColor,
      barrierDismissible: false,
    );
  }
}

class LoadingIndicator extends StatelessWidget {
  final Color color;

  const LoadingIndicator({
    super.key,
    this.color = AppThemeData.indicatorColor,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: color,
      ),
    );
  }
}
