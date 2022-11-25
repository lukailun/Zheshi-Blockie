// Dart imports:
import 'dart:math';
import 'dart:ui';

// Flutter imports:
import 'package:blockie_app/data/models/nft_info.dart';
import 'package:blockie_app/widgets/blur.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/extensions/extensions.dart';
import 'package:blockie_app/data/models/app_theme_data.dart';
import 'package:blockie_app/widgets/basic_elevated_button.dart';

extension GetDialogExtension on GetInterface {
  void projectDetailsMintedNftDialog({
    required NftInfo nft,
    Function()? buttonOnTap,
  }) {
    Get.dialog(
      ProjectDetailsMintedNftDialog(
        nft: nft,
        buttonOnTap: buttonOnTap,
      ),
      barrierColor: AppThemeData.barrierColor,
    );
  }
}

class ProjectDetailsMintedNftDialog extends StatelessWidget {
  final NftInfo nft;
  final Function()? buttonOnTap;

  const ProjectDetailsMintedNftDialog({
    super.key,
    required this.nft,
    this.buttonOnTap,
  });

  @override
  Widget build(BuildContext context) {
    return Blur(
      blur: 5,
      blurColor: const Color(0x10FFFFFF),
      colorOpacity: 0.05,
      child: Center(
        child: Container(
          decoration: const BoxDecoration(
            color: AppThemeData.primaryColor,
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
          ),
          width: min(Get.width - 75, 300),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AspectRatio(
                    aspectRatio: 1,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8),
                      ),
                      child: CachedNetworkImage(
                        imageUrl: nft.cover,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Text(
                    '${nft.projectName} ${nft.tokenId}',
                    maxLines: 100,
                    textAlign: TextAlign.center,
                  ).textColor(Colors.white).fontSize(20).paddingAll(17),
                ],
              ).outlined().paddingSymmetric(vertical: 17),
              BasicElevatedButton(
                title: '立即查看',
                backgroundColor: Colors.white,
                textColor: AppThemeData.primaryColor,
                borderRadius: 8,
                onTap: buttonOnTap,
              ),
              RichText(
                text: TextSpan(
                  text: "您之后可以在 ",
                  style:
                      const TextStyle(color: Color(0x80FFFFFF), fontSize: 14),
                  children: [
                    TextSpan(
                      text: '我的 - ${nft.type == 2 ? '视频凭证' : '运动凭证'}',
                      style: const TextStyle(
                          color: Color(0xCCFFFFFF), fontSize: 14),
                    ),
                    const TextSpan(
                      text: " 查看",
                      style: TextStyle(color: Color(0x80FFFFFF), fontSize: 14),
                    ),
                  ],
                ),
              ).paddingSymmetric(vertical: 17),
            ],
          ).paddingSymmetric(horizontal: 17),
        ),
      ),
    );
  }
}
