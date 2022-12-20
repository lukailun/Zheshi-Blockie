// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/app/modules/project_details/controllers/project_details_controller.dart';
import 'package:blockie_app/app/modules/project_details/models/project_details.dart';
import 'package:blockie_app/app/modules/project_details/views/project_details_cover_view.dart';
import 'package:blockie_app/app/modules/project_details/views/project_details_footer_view.dart';
import 'package:blockie_app/data/models/app_bar_button_item.dart';
import 'package:blockie_app/data/models/app_theme_data.dart';
import 'package:blockie_app/data/models/mint_status.dart';
import 'package:blockie_app/data/models/nft_paster_type.dart';
import 'package:blockie_app/extensions/extensions.dart';
import 'package:blockie_app/widgets/basic_app_bar.dart';
import 'package:blockie_app/widgets/basic_details_card.dart';
import 'package:blockie_app/widgets/loading_indicator.dart';

class ProjectDetailsContainerView extends GetView<ProjectDetailsController> {
  const ProjectDetailsContainerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return Scaffold(
          backgroundColor: AppThemeData.primaryColor,
          extendBodyBehindAppBar: true,
          appBar: BasicAppBar(
            actionItems: [
              AppBarButtonItem(
                assetName: "assets/images/app_bar/share.png",
                onTap: controller.goToShare,
              ),
              AppBarButtonItem(
                assetName: "assets/images/app_bar/menu.png",
                items: [
                  AppBarButtonItem(
                    title: '首页',
                    assetName: "assets/images/app_bar/home.png",
                    onTap: controller.goToActivities,
                  ),
                  AppBarButtonItem(
                    title: '我的',
                    assetName: "assets/images/app_bar/user.png",
                    onTap: controller.goToProfile,
                  ),
                  AppBarButtonItem(
                    title: '活动规则',
                    assetName: "assets/images/app_bar/info.png",
                    onTap: controller.goToActivity,
                  ),
                ],
              ),
            ],
          ),
          body: () {
            final projectDetails = controller.projectDetails.value;
            if (projectDetails == null) {
              return const LoadingIndicator();
            } else {
              return _ProjectDetailsView(
                projectDetails: projectDetails,
                mintStatus: controller.mintStatus.value,
                galleryOnTap: controller.goToGallery,
                brandOnTap: controller.goToBrandDetails,
                hintOnTap: controller.openHintDialog,
                mintButtonOnTap: () =>
                    controller.prepareToMint(projectDetails.id),
              );
            }
          }(),
        );
      },
    );
  }
}

class _ProjectDetailsView extends StatelessWidget {
  final ProjectDetails projectDetails;
  final MintStatus mintStatus;
  final Function(int) galleryOnTap;
  final Function(String) brandOnTap;
  final Function() hintOnTap;
  final Function() mintButtonOnTap;

  const _ProjectDetailsView({
    Key? key,
    required this.projectDetails,
    required this.mintStatus,
    required this.galleryOnTap,
    required this.brandOnTap,
    required this.hintOnTap,
    required this.mintButtonOnTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cover = ProjectDetailsCoverView(
        projectDetails: projectDetails, galleryOnTap: galleryOnTap);

    final title = Text(projectDetails.name)
        .fontSize(20)
        .textColor(Colors.white)
        .paddingOnly(left: 22, right: 22, bottom: 8);

    final brand = GestureDetector(
      onTap: () => brandOnTap(projectDetails.issuer.id),
      child: Row(
        children: [
          CircleAvatar(
            radius: 16,
            backgroundImage: NetworkImage(
              projectDetails.issuer.logoUrl ?? '',
            ),
          ),
          Text(projectDetails.issuer.title)
              .fontSize(14)
              .textColor(Colors.white)
              .paddingOnly(left: 10),
        ],
      ),
    ).paddingSymmetric(horizontal: 22);

    final time = Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text('铸造时间')
            .textColor(const Color(0x80FFFFFF))
            .fontSize(12)
            .fontWeight(FontWeightCompat.regular),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
                  '${projectDetails.startedTime ?? ''} ~ ${projectDetails.endedTime ?? ''}')
              .textColor(const Color(0xFFCAFF04))
              .fontSize(12)
              .fontWeight(FontWeightCompat.bold),
        ),
      ],
    ).paddingOnly(left: 25, right: 25, top: 18, bottom: 2);

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
    );

    final description = Text(
      projectDetails.description,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    )
        .textColor(const Color(0xCCFFFFFF))
        .paddingOnly(left: 25, right: 25, top: 6);

    final details = Stack(
      children: [
        BasicDetailsCard(items: projectDetails.items),
        Positioned(
          top: 0,
          right: 0,
          child: Visibility(
            visible: projectDetails.pasterType != NftPasterType.undefined,
            child: Container(
              transform: Matrix4.translationValues(16.0, -16.0, 0.0),
              child: Image.asset(
                projectDetails.pasterType.assetName,
                width: 96,
                height: 96,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
      ],
    ).paddingOnly(left: 44, right: 44, top: 24, bottom: 20);

    final footer = ProjectDetailsFooterView(
      projectDetails: projectDetails,
      mintStatus: mintStatus,
      hintOnTap: hintOnTap,
      buttonOnTap: mintButtonOnTap,
    );

    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              cover,
              Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: 100,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0xFF696969),
                          AppThemeData.primaryColor,
                        ],
                      ),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                      ),
                    ),
                    transform: Matrix4.translationValues(0.0, -16.0, 0.0),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      title,
                      brand,
                      time,
                      divider,
                      description,
                      details,
                    ],
                  ).paddingOnly(bottom: 160),
                ],
              ),
            ],
          ),
        ),
        Container(
          alignment: Alignment.bottomCenter,
          child: footer,
        ),
      ],
    );
  }
}
