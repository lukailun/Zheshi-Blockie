// Flutter imports:
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/models/app_theme_data.dart';

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
  const LoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: AppThemeData.indicatorColor,
      ),
    );
  }
}
