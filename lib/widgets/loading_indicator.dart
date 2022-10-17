// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:blockie_app/models/app_theme_data.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: CircularProgressIndicator(
      color: AppThemeData.indicatorColor,
    ));
  }
}
