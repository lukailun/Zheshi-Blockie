// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/app/modules/airdrop_nft/controllers/airdrop_nft_controller.dart';
import 'package:blockie_app/app/modules/airdrop_nft/models/airdrop_nft_details.dart';
import 'package:blockie_app/app/modules/airdrop_nft/views/airdrop_nft_item_view.dart';
import 'package:blockie_app/data/models/app_theme_data.dart';
import 'package:blockie_app/extensions/text_extension.dart';
import 'package:blockie_app/widgets/basic_app_bar.dart';
import 'package:blockie_app/widgets/projects_management_footer_view.dart';
import 'package:blockie_app/widgets/projects_management_user_view.dart';

class AirdropNftContainerView extends GetView<AirdropNftController> {
  const AirdropNftContainerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: AppThemeData.primaryColor,
        appBar: BasicAppBar(title: '空投 NFT'),
        body: () {
          final airdropNftDetailsValue = controller.airdropNftDetails.value;
          return Stack(
            children: [
              () {
                if (airdropNftDetailsValue == null) {
                  return const SizedBox();
                } else {
                  return _AirdropNftView(
                    airdropNftDetails: airdropNftDetailsValue,
                    activityOnTap: () {
                      airdropNftDetailsValue.activity.isSelected =
                          !airdropNftDetailsValue.activity.isSelected;
                      controller.airdropNftDetails.value = null;
                      controller.airdropNftDetails.value =
                          airdropNftDetailsValue;
                    },
                  ).paddingOnly(bottom: 182);
                }
              }(),
              ProjectsManagementFooterView(
                topButtonTitle: '空投所选 NFT',
                bottomButtonTitle: '继续扫码',
                topButtonIsEnabled: controller.airdropNftButtonIsEnabled(),
                topButtonOnTap: controller.airdropNft,
                bottomButtonOnTap: controller.scanQrCode,
              ),
            ],
          );
        }(),
      ),
    );
  }
}

class _AirdropNftView extends StatelessWidget {
  final AirdropNftDetails airdropNftDetails;
  final Function()? activityOnTap;

  const _AirdropNftView({
    required this.airdropNftDetails,
    this.activityOnTap,
  });

  @override
  Widget build(BuildContext context) {
    final userView = ProjectsManagementUserView(user: airdropNftDetails.user);
    final title = SizedBox(
      width: double.infinity,
      child: const Text('选择 NFT 款式').textColor(Colors.white).fontSize(18),
    ).paddingOnly(left: 22, right: 22, bottom: 22);
    final activityView = AirdropNftItemView(
      activity: airdropNftDetails.activity,
      activityOnTap: activityOnTap,
    ).paddingSymmetric(horizontal: 22);
    return Column(
      children: [
        userView,
        title,
        activityView,
        const Spacer(flex: 1),
      ],
    );
  }
}
