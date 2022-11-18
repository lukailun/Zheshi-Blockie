// Dart imports:
import 'dart:ui';

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/app/modules/profile/controllers/profile_controller.dart';
import 'package:blockie_app/app/modules/project_details/controllers/project_details_controller.dart';
import 'package:blockie_app/app/modules/project_details/models/project_details.dart';
import 'package:blockie_app/app/modules/project_details/views/project_details_cover_view.dart';
import 'package:blockie_app/app/modules/project_details/views/project_details_footer_view.dart';
import 'package:blockie_app/app/routes/app_pages.dart';
import 'package:blockie_app/extensions/extensions.dart';
import 'package:blockie_app/models/app_bar_button_item.dart';
import 'package:blockie_app/models/app_theme_data.dart';
import 'package:blockie_app/models/mint_status.dart';
import 'package:blockie_app/services/auth_service.dart';
import 'package:blockie_app/utils/clipboard_utils.dart';
import 'package:blockie_app/widgets/basic_app_bar.dart';
import 'package:blockie_app/widgets/basic_icon_button.dart';
import 'package:blockie_app/widgets/ellipsized_text.dart';
import 'package:blockie_app/widgets/expandable_text.dart';
import 'package:blockie_app/widgets/loading_indicator.dart';
import 'package:blockie_app/widgets/message_toast.dart';

class ProjectDetailsContainerView extends GetView<ProjectDetailsController> {
  const ProjectDetailsContainerView({super.key});

  @override
  Widget build(BuildContext context) {
    final menuItems = [
      AppBarButtonItem(
        title: '首页',
        assetName: "assets/images/app_bar/home.png",
        onTap: () => Get.offAllNamed(Routes.activities),
      ),
      AppBarButtonItem(
        title: '我的',
        assetName: "assets/images/app_bar/user.png",
        onTap: () {
          final parameters = {
            ProfileParameter.id: AuthService.to.user.value?.id ?? "",
          };
          Get.offNamed(Routes.profile, parameters: parameters);
        },
      ),
      AppBarButtonItem(
        title: '活动规则',
        assetName: "assets/images/app_bar/info.png",
        onTap: controller.goToActivity,
      ),
    ];
    return Obx(
      () => Scaffold(
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
              items: menuItems,
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
      ),
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
        .paddingSymmetric(horizontal: 22, vertical: 14);

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

    final description = ExpandableText(
      text: projectDetails.description,
      maxLines: 2,
    ).paddingSymmetric(horizontal: 22, vertical: 14);

    final details = Column(
      children: projectDetails.items.asMap().entries.map(
        (it) {
          final index = it.key;
          final item = it.value;
          return Column(
            children: [
              Row(
                children: [
                  Text(item.title)
                      .textColor(const Color(0xB3FFFFFF))
                      .fontSize(14)
                      .paddingOnly(right: 35),
                  Expanded(
                    child: item.ellipsized
                        ? EllipsizedText(
                            item.content,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 14),
                            ellipsis: Ellipsis.middle,
                          )
                        : Text(
                            item.content,
                            textAlign: TextAlign.right,
                            maxLines: 10,
                            overflow: TextOverflow.ellipsis,
                          ).textColor(Colors.white).fontSize(14),
                  ),
                  Offstage(
                    offstage: !item.copyable,
                    child: BasicIconButton(
                      assetName: "assets/images/common/copy.png",
                      size: 24,
                      onTap: () {
                        final copySuccess =
                            ClipboardUtils.copyToClipboard(item.content);
                        MessageToast.showMessage(copySuccess ? '复制成功' : '复制失败');
                      },
                    ).paddingOnly(left: 10),
                  ),
                ],
              ).paddingSymmetric(vertical: 14),
              Offstage(
                offstage: index == projectDetails.items.length - 1,
                child: const Divider(
                  color: Color(0x32FFFFFF),
                  thickness: 1,
                ),
              ),
            ],
          );
        },
      ).toList(),
    ).paddingOnly(left: 22, right: 22, top: 14, bottom: 174);

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
                      description,
                      details,
                    ],
                  )
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
