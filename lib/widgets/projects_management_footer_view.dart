// Dart imports:
import 'dart:ui';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/data/models/app_theme_data.dart';
import 'package:blockie_app/widgets/blur.dart';
import 'basic_elevated_button.dart';

class ProjectsManagementFooterView extends StatelessWidget {
  final String? topButtonTitle;
  final String bottomButtonTitle;
  final bool? topButtonIsEnabled;
  final Function()? topButtonOnTap;
  final Function() bottomButtonOnTap;

  const ProjectsManagementFooterView({
    Key? key,
    required this.topButtonTitle,
    required this.bottomButtonTitle,
    required this.topButtonIsEnabled,
    required this.topButtonOnTap,
    required this.bottomButtonOnTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final topButton = BasicElevatedButton(
      title: topButtonTitle ?? '',
      borderRadius: 12,
      textFontSize: 18,
      backgroundColor: Colors.white,
      textColor: AppThemeData.primaryColor,
      onTap: topButtonOnTap,
      isEnabled: topButtonIsEnabled ?? false,
    );

    final bottomButton = BasicElevatedButton(
      title: bottomButtonTitle,
      borderRadius: 12,
      textFontSize: 18,
      onTap: bottomButtonOnTap,
    );

    return Container(
      alignment: Alignment.bottomCenter,
      child: Container(
        decoration: const BoxDecoration(
            border: Border(top: BorderSide(color: Colors.white24, width: 1))),
        width: double.infinity,
        height: topButtonTitle != null ? 160 : 90,
        child: ClipRect(
          child: Blur(
            blur: 5,
            blurColor: const Color(0x10FFFFFF),
            colorOpacity: 0.05,
            child: Column(
              children: [
                const Spacer(flex: 1),
                Visibility(
                  visible: topButtonTitle != null,
                  child: SizedBox(
                    height: 48,
                    child: topButton,
                  ).paddingOnly(bottom: 22),
                ),
                SizedBox(
                  height: 48,
                  child: bottomButton,
                ),
                const Spacer(flex: 1),
              ],
            ).paddingSymmetric(horizontal: 20),
          ),
        ),
      ),
    );
  }
}
