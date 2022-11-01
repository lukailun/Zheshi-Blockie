// Dart imports:
import 'dart:ui';

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/app/modules/profile/controllers/profile_controller.dart';
import 'package:blockie_app/app/modules/profile/models/profile.dart';
import 'package:blockie_app/app/modules/profile/views/profile_nfts_view.dart';
import 'package:blockie_app/extensions/extensions.dart';
import 'package:blockie_app/models/app_bar_button_item.dart';
import 'package:blockie_app/models/app_theme_data.dart';
import 'package:blockie_app/models/user_info.dart';
import 'package:blockie_app/widgets/basic_app_bar.dart';
import 'package:blockie_app/widgets/basic_elevated_button.dart';
import 'package:blockie_app/widgets/basic_icon_button.dart';
import 'package:blockie_app/widgets/ellipsized_text.dart';
import 'package:blockie_app/widgets/loading_indicator.dart';

class ProfileContainerView extends GetView<ProfileController> {
  const ProfileContainerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: AppThemeData.primaryColor,
        appBar: BasicAppBar(
          backButtonOnTap: controller.goToProjects,
          actionItems: [
            AppBarButtonItem(
              assetName: 'assets/images/app_bar/qr_code.png',
              onTap: controller.openQrCodeDialog,
            ),
            AppBarButtonItem(
              assetName: 'assets/images/app_bar/settings.png',
              onTap: controller.goToSettings,
            ),
          ],
        ),
        body: () {
          final userValue = controller.user.value;
          final profileValue = controller.profile.value;
          if (userValue == null || profileValue == null) {
            return const LoadingIndicator();
          } else {
            return _ProfileView(
              user: userValue,
              profile: profileValue,
              avatarOnTap: controller.goToUpdateAvatar,
              nameOnTap: controller.goToUpdateName,
              walletAddressOnTap: controller.copyWalletAddress,
              bioOnTap: controller.goToUpdateBio,
              nftOnTap: controller.goToNftDetails,
            );
          }
        }(),
      ),
    );
  }
}

class _ProfileView extends StatelessWidget {
  final UserInfo user;
  final Profile profile;
  final Function() avatarOnTap;
  final Function() nameOnTap;
  final Function() bioOnTap;
  final Function(String) walletAddressOnTap;
  final Function(String) nftOnTap;

  const _ProfileView({
    required this.user,
    required this.profile,
    required this.avatarOnTap,
    required this.nameOnTap,
    required this.bioOnTap,
    required this.walletAddressOnTap,
    required this.nftOnTap,
  });

  @override
  Widget build(BuildContext context) {
    final List<Widget> avatar = [
      GestureDetector(
        onTap: avatarOnTap,
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(40)),
          child: CachedNetworkImage(
            imageUrl: user.avatar,
            width: 80,
            height: 80,
            fit: BoxFit.cover,
          ),
        ),
      ),
      const Spacer(flex: 1),
    ];
    final List<Widget> tagsView = profile.tags.map((it) {
      return Column(
        children: [
          const SizedBox(height: 20),
          Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/profile/tag_background.png"),
              ),
            ),
            child: Center(
              child: CachedNetworkImage(
                imageUrl: it.iconUrl,
                width: 20,
                height: 20,
                fit: BoxFit.contain,
              ),
            ),
          ),
          SizedBox(
            height: 20,
            child: Center(
              child: Text(it.name).fontSize(10).textColor(Colors.white),
            ),
          ),
        ],
      ).paddingSymmetric(horizontal: 5.5);
    }).toList();
    while (tagsView.length < 3) {
      tagsView.add(
        Column(
          children: [
            const SizedBox(height: 20),
            Image.asset(
              'assets/images/profile/tag_add.png',
              width: 40,
              height: 40,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 20),
          ],
        ).paddingSymmetric(horizontal: 5.5),
      );
    }
    final avatarAndTagsView = Row(
      children: avatar + tagsView,
    ).paddingOnly(left: 22, right: 38.5);
    final name = Row(
      children: [
        Text(user.nickname)
            .textColor(Colors.white)
            .fontSize(20)
            .paddingOnly(left: 22, top: 12, bottom: 12),
        BasicIconButton(
          assetName: 'assets/images/common/edit.png',
          size: 20,
          onTap: nameOnTap,
        ).paddingOnly(left: 9),
        const Spacer(flex: 1),
      ],
    );
    final contract = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('区块链地址: ',
            style: TextStyle(fontSize: 12, color: Color(0xCCFFFFFF))),
        SizedBox(
          width: 200,
          child: EllipsizedText(
            user.walletAddress ?? '',
            style: const TextStyle(fontSize: 12, color: Color(0xCCFFFFFF)),
            ellipsis: Ellipsis.middle,
          ),
        ),
        BasicIconButton(
          assetName: 'assets/images/common/copy.png',
          size: 20,
          onTap: () => walletAddressOnTap(user.walletAddress ?? ''),
        ).paddingOnly(left: 9),
        const Spacer(flex: 1),
      ],
    ).paddingSymmetric(horizontal: 22);
    final bio = Opacity(
      opacity: 0,
      child: Row(
        children: [
          Text(user.nickname)
              .textColor(Colors.white)
              .fontSize(15)
              .paddingOnly(left: 22, top: 7, bottom: 7),
          BasicIconButton(
            assetName: 'assets/images/common/edit.png',
            size: 20,
            onTap: bioOnTap,
          ).paddingOnly(left: 9),
          const Spacer(flex: 1),
        ],
      ),
    );
    final divider = Container(
      height: 2,
      decoration: const BoxDecoration(
        color: Colors.black,
        shape: BoxShape.rectangle,
        boxShadow: [
          BoxShadow(
            color: Color(0x4DFFFFFF),
            spreadRadius: 0,
            blurRadius: 2,
            offset: Offset(-2, 1),
          ),
          BoxShadow(
            color: Colors.black,
            spreadRadius: 0,
            blurRadius: 8,
            offset: Offset(-1, -1),
          ),
        ],
      ),
    ).paddingSymmetric(vertical: 23);
    final userInfoView = Stack(
      children: [
        Container(
          width: double.infinity,
          height: 80,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF696969),
                Color(0xFF202020),
              ],
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
          ),
          transform: Matrix4.translationValues(0.0, 40.0, 0.0),
        ),
        Column(
          children: [
            avatarAndTagsView,
            name,
            contract,
            bio,
            divider,
          ],
        ),
      ],
    );
    final videoNftsView = ProfileNftsView(
      title: '视频凭证',
      nfts: profile.nfts.videoNfts ?? [],
      defaultAssetName: 'assets/images/profile/empty_video_nft.png',
      isCircular: false,
      nftOnTap: nftOnTap,
    );
    final sportNftsView = ProfileNftsView(
      title: '运动凭证',
      nfts: profile.nfts.sportNfts ?? [],
      defaultAssetName: 'assets/images/profile/empty_sport_nft.png',
      isCircular: true,
      nftOnTap: nftOnTap,
    );
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          userInfoView,
          videoNftsView,
          sportNftsView,
        ],
      ),
    );
  }
}
