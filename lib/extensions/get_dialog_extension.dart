// Dart imports:
import 'dart:ui';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/widgets/basic_one_button_dialog.dart';

extension GetDialogExtension on GetInterface {
  void oneButtonDialog({
    required String title,
    required String message,
    required String buttonTitle,
    required VoidCallback buttonOnTap,
  }) {
    Get.dialog(
      BasicOneButtonDialog(
        title: title,
        message: message,
        buttonTitle: buttonTitle,
        buttonOnTap: buttonOnTap,
      ),
      barrierColor: const Color(0x80FFFFFF),
    );
  }
}
