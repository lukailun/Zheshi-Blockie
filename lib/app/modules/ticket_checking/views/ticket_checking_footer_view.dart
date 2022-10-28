// Dart imports:
import 'dart:ui';

// Flutter imports:
import 'package:blockie_app/models/app_theme_data.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/widgets/basic_elevated_button.dart';

class TicketCheckingFooterView extends StatelessWidget {
  final bool checkTicketIsEnabled;
  final Function() checkTicketOnTap;
  final Function() scanOnTap;

  const TicketCheckingFooterView({
    Key? key,
    required this.checkTicketIsEnabled,
    required this.checkTicketOnTap,
    required this.scanOnTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final checkTicketButton = BasicElevatedButton(
      title: '核销所选NFT权益',
      borderRadius: 12,
      textFontSize: 18,
      backgroundColor: Colors.white,
      textColor: AppThemeData.primaryColor,
      onTap: checkTicketOnTap,
      isEnabled: checkTicketIsEnabled,
    );

    final scanButton = BasicElevatedButton(
      title: '继续扫码',
      borderRadius: 12,
      textFontSize: 18,
      onTap: scanOnTap,
    );

    return Container(
      decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: Colors.white24, width: 1))),
      width: double.infinity,
      height: 160,
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Column(
            children: [
              const Spacer(flex: 1),
              SizedBox(
                height: 48,
                child: checkTicketButton,
              ),
              const SizedBox(height: 22),
              SizedBox(
                height: 48,
                child: scanButton,
              ),
              const Spacer(flex: 1),
            ],
          ).paddingSymmetric(horizontal: 20),
        ),
      ),
    );
  }
}
