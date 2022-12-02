// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/app/modules/hold_verification/controllers/hold_verification_controller.dart';
import 'package:blockie_app/app/modules/hold_verification/models/hold_verification_details.dart';
import 'package:blockie_app/app/modules/hold_verification/views/hold_verification_item_view.dart';
import 'package:blockie_app/data/models/app_theme_data.dart';
import 'package:blockie_app/extensions/text_extension.dart';
import 'package:blockie_app/widgets/basic_app_bar.dart';
import 'package:blockie_app/widgets/projects_management_footer_view.dart';
import 'package:blockie_app/widgets/projects_management_user_view.dart';

class HoldVerificationContainerView
    extends GetView<HoldVerificationController> {
  const HoldVerificationContainerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: AppThemeData.primaryColor,
        appBar: BasicAppBar(title: '持有验证'),
        body: () {
          final holdVerificationDetailsValue =
              controller.holdVerificationDetails.value;
          return Stack(
            children: [
              () {
                if (holdVerificationDetailsValue == null) {
                  return const SizedBox();
                } else {
                  return _HoldVerificationView(
                    holdVerificationDetails: holdVerificationDetailsValue,
                  ).paddingOnly(bottom: 112);
                }
              }(),
              ProjectsManagementFooterView(
                topButtonTitle: null,
                bottomButtonTitle: '继续扫码',
                topButtonIsEnabled: null,
                topButtonOnTap: null,
                bottomButtonOnTap: controller.scanQrCode,
              ),
            ],
          );
        }(),
      ),
    );
  }
}

class _HoldVerificationView extends StatelessWidget {
  final HoldVerificationDetails holdVerificationDetails;

  const _HoldVerificationView({
    required this.holdVerificationDetails,
  });

  @override
  Widget build(BuildContext context) {
    final userView =
        ProjectsManagementUserView(user: holdVerificationDetails.user);
    final title = SizedBox(
      width: double.infinity,
      child: const Text('选择 NFT 款式').textColor(Colors.white).fontSize(18),
    ).paddingOnly(left: 22, right: 22, bottom: 22);
    final items = ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 22),
      itemCount: holdVerificationDetails.nfts.length,
      itemBuilder: (_, index) {
        return HoldVerificationItemView(
            nft: holdVerificationDetails.nfts[index]);
      },
      separatorBuilder: (context, index) => const SizedBox(height: 22),
    );
    return Column(
      children: [
        userView,
        title,
        Expanded(child: items),
      ],
    );
  }
}
