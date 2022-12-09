// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:cached_network_image/cached_network_image.dart';
import 'package:extended_wrap/extended_wrap.dart';
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/app/modules/profile/controllers/profile_controller.dart';
import 'package:blockie_app/app/modules/profile/views/label_view.dart';
import 'package:blockie_app/app/modules/profile/views/profile_nfts_view.dart';
import 'package:blockie_app/app/modules/profile/views/tag_view.dart';
import 'package:blockie_app/data/models/app_bar_button_item.dart';
import 'package:blockie_app/data/models/app_theme_data.dart';
import 'package:blockie_app/extensions/extensions.dart';
import 'package:blockie_app/widgets/basic_app_bar.dart';
import 'package:blockie_app/widgets/basic_elevated_button.dart';
import 'package:blockie_app/widgets/ellipsized_text.dart';
import 'package:blockie_app/widgets/loading_indicator.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

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
          final userInfo = controller.userInfo.value;
          final profile = controller.profile.value;
          if (userInfo == null || profile == null) {
            return const LoadingIndicator();
          } else {
            final List<Widget> avatar = [
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(40)),
                child: CachedNetworkImage(
                  imageUrl: userInfo.avatarUrl,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),
              const Spacer(flex: 1),
            ];
            final List<Widget> labelsView = profile.labels
                .map((it) => LabelView(label: it).paddingOnly(top: 20))
                .toList();
            while (labelsView.length < 3) {
              labelsView.add(
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
            final avatarAndLabelsView = Row(
              children: avatar +
                  labelsView
                      .asMap()
                      .entries
                      .map((it) => GestureDetector(
                            onTap: () =>
                                controller.openUpdateLabelsDialog(it.key),
                            child: it.value,
                          ))
                      .toList(),
            ).paddingOnly(left: 22, right: 38.5);
            final name = Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(userInfo.username)
                    .textColor(Colors.white)
                    .fontSize(20)
                    .paddingSymmetric(vertical: 12),
                const Spacer(flex: 1),
                GestureDetector(
                  onTap: controller.goToEditUserInfo,
                  behavior: HitTestBehavior.translucent,
                  child: SizedBox(
                    width: 108,
                    height: 33,
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: Image.asset(
                            'assets/images/profile/edit_profile_background.png',
                            width: 108,
                            height: 33,
                            fit: BoxFit.contain,
                          ),
                        ),
                        Center(
                          child: const Text('编辑资料')
                              .fontSize(11)
                              .textColor(const Color(0xFFEBEBEB)),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ).paddingSymmetric(horizontal: 22);
            final contract = Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('区块链地址: ',
                    style: TextStyle(fontSize: 12, color: Color(0xCCFFFFFF))),
                SizedBox(
                  width: 200,
                  child: EllipsizedText(
                    userInfo.walletAddress ?? '',
                    style:
                        const TextStyle(fontSize: 12, color: Color(0xCCFFFFFF)),
                    ellipsis: Ellipsis.middle,
                  ),
                ),
                const Spacer(flex: 1),
              ],
            ).paddingSymmetric(horizontal: 22);
            final bio = Row(
              children: [
                Flexible(
                  child: Text(
                    userInfo.bio.isNotEmpty ? userInfo.bio : '用一句话介绍下自己吧~',
                    maxLines: 100,
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                  )
                      .textColor(Colors.white)
                      .fontSize(15)
                      .paddingSymmetric(vertical: 7),
                ),
              ],
            ).paddingSymmetric(horizontal: 22);
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
                    avatarAndLabelsView,
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
              nftOnTap: controller.goToNftDetails,
            );
            final sportNftsView = ProfileNftsView(
              title: '运动凭证',
              nfts: profile.nfts.sportNfts ?? [],
              defaultAssetName: 'assets/images/profile/empty_sport_nft.png',
              isCircular: true,
              nftOnTap: controller.goToNftDetails,
            );
            final tagViews =
                profile.tags.map((it) => TagView(tag: it)).toList();
            final tagsView = Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text('个人标签')
                        .fontSize(15)
                        .textColor(const Color(0xCCFFFFFF)),
                    const Spacer(flex: 1),
                    Container(
                      padding: const EdgeInsets.only(left: 7),
                      child: Visibility(
                        visible: profile.tags.isNotEmpty,
                        child: GestureDetector(
                          onTap: controller.toggleTags, // Image tapped
                          child: Image.asset(
                            controller.isTagsExpanded.value
                                ? 'assets/images/common/collapse.png'
                                : 'assets/images/common/expand.png',
                            width: 24,
                            height: 24,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Visibility(
                  visible: profile.tags.isNotEmpty,
                  replacement: Image.asset(
                    'assets/images/profile/empty_tag.png',
                    width: 113,
                    height: 27,
                    fit: BoxFit.contain,
                  ),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: controller.isTagsExpanded.value
                        ? Wrap(
                            spacing: 11,
                            runSpacing: 11,
                            children: tagViews,
                          )
                        : ExtendedWrap(
                            maxLines: 3,
                            spacing: 11,
                            runSpacing: 11,
                            children: tagViews,
                          ),
                  ),
                ).paddingOnly(top: 10, bottom: 90),
              ],
            ).paddingSymmetric(horizontal: 22);
            final copyright = Center(
              child: RichText(
                text: const TextSpan(
                  text: "Powered by ",
                  style: TextStyle(
                    color: Color(0xCCEFEFEF),
                    fontSize: 12,
                    fontWeight: FontWeightCompat.regular,
                  ),
                  children: [
                    TextSpan(
                      text: 'BLOCKIE',
                      style: TextStyle(
                        color: Color(0xCCEFEFEF),
                        fontSize: 12,
                        fontWeight: FontWeightCompat.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ).paddingOnly(bottom: 50);
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  userInfoView,
                  videoNftsView,
                  sportNftsView,
                  tagsView,
                  copyright,
                ],
              ),
            );
          }
        }(),
      ),
    );
  }
}
