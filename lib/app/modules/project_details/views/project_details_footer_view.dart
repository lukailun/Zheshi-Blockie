// Dart imports:
import 'dart:ui';

// Flutter imports:
import 'package:blockie_app/data/models/mint_status.dart';
import 'package:blockie_app/widgets/blur.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/app/modules/project_details/models/project_details.dart';
import 'package:blockie_app/extensions/extensions.dart';
import 'package:blockie_app/widgets/basic_elevated_button.dart';

class ProjectDetailsFooterView extends StatelessWidget {
  final ProjectDetails projectDetails;
  final MintStatus mintStatus;
  final VoidCallback hintOnTap;
  final VoidCallback buttonOnTap;

  const ProjectDetailsFooterView({
    Key? key,
    required this.projectDetails,
    required this.mintStatus,
    required this.hintOnTap,
    required this.buttonOnTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final hintText = GestureDetector(
      onTap: mintStatus.showsHint ? hintOnTap : null,
      child: SizedBox(
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(mintStatus.hint(
              userMintedAmount: projectDetails.userMintedAmount ?? 0,
              mintChances: projectDetails.mintChances,
            )).textColor(Colors.white).fontSize(17),
            Offstage(
              offstage: !mintStatus.showsHint,
              child: Image.asset(
                "assets/images/project_details/hint.png",
                width: 20,
                height: 20,
              ).paddingOnly(left: 5),
            )
          ],
        ),
      ),
    );

    final mintButton = BasicElevatedButton(
      title: mintStatus.title(
        startedTime: projectDetails.startedTime,
        isVideoNft: projectDetails.isVideoNft,
      ),
      borderRadius: 12,
      backgroundColor: Color(mintStatus.colorValue),
      textColor: Colors.black,
      textFontSize: 20,
      isLoading: mintStatus == MintStatus.minting,
      onTap: mintStatus.enabled ? buttonOnTap : null,
    );

    return Container(
      decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: Colors.white24, width: 1))),
      width: double.infinity,
      height: 160,
      child: ClipRect(
        child: Blur(
          blur: 5,
          blurColor: const Color(0x10FFFFFF),
          colorOpacity: 0.05,
          child: Column(
            children: [
              hintText.paddingSymmetric(vertical: 16),
              SizedBox(
                height: 60,
                child: mintButton,
              ).paddingSymmetric(horizontal: 20),
            ],
          ),
        ),
      ),
    );
  }
}
