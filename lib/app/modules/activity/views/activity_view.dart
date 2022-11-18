// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/app/modules/activity/controllers/activity_controller.dart';
import 'package:blockie_app/app/modules/activity/models/activity.dart';
import 'package:blockie_app/models/subactivity_step.dart';
import 'package:blockie_app/app/modules/activity/views/subactivity_view.dart';
import 'package:blockie_app/app/modules/profile/controllers/profile_controller.dart';
import 'package:blockie_app/app/routes/app_pages.dart';
import 'package:blockie_app/extensions/extensions.dart';
import 'package:blockie_app/models/app_bar_button_item.dart';
import 'package:blockie_app/models/app_theme_data.dart';
import 'package:blockie_app/services/auth_service.dart';
import 'package:blockie_app/widgets/basic_app_bar.dart';
import 'package:blockie_app/widgets/loading_indicator.dart';

class ActivityContainerView extends GetView<ActivityController> {
  const ActivityContainerView({super.key});

  @override
  Widget build(BuildContext context) {
    final showsBack = Get.routing.previous.isNotEmpty;
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
    ];
    return Obx(
      () => Scaffold(
        backgroundColor: AppThemeData.primaryColor,
        appBar: BasicAppBar(
          showsLogo: !showsBack,
          paddingTop: 0,
          title: showsBack && !controller.headerIsExpanded.value
              ? controller.activity.value?.name
              : null,
          backgroundColor: AppThemeData.primaryColor,
          actionItems: [
            AppBarButtonItem(
              assetName: "assets/images/app_bar/menu.png",
              items: menuItems,
            ),
          ],
        ),
        body: () {
          final activityValue = controller.activity.value;
          if (activityValue == null) {
            return const LoadingIndicator();
          } else {
            return _ActivityView(
              activity: activityValue,
              controller: controller,
              issuerOnTap: controller.goToBrandDetails,
            );
          }
        }(),
      ),
    );
  }
}

class _ActivityView extends StatelessWidget {
  final Activity activity;

  final ActivityController controller;
  final Function(String)? issuerOnTap;

  const _ActivityView({
    required this.activity,
    required this.controller,
    this.issuerOnTap,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        final title = SizedBox(
          width: double.infinity,
          child: Text(
            activity.name.formatted,
            maxLines: 100,
          )
              .fontSize(32)
              .fontWeight(FontWeightCompat.regular)
              .textColor(Colors.white),
        ).paddingSymmetric(horizontal: 22);
        final issuer = GestureDetector(
          onTap: () => issuerOnTap?.call(activity.issuer.id),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: CachedNetworkImage(
                  imageUrl: activity.issuer.logoUrl ?? '',
                  width: 32,
                  height: 32,
                  fit: BoxFit.cover,
                ),
              ),
              Flexible(
                child: Text(
                  activity.issuer.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                )
                    .textColor(Colors.white)
                    .fontWeight(FontWeightCompat.regular)
                    .fontSize(14)
                    .paddingSymmetric(horizontal: 10),
              ),
            ],
          ),
        ).paddingSymmetric(horizontal: 22, vertical: 16);

        final tabBar = Theme(
          data: ThemeData(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
          child: TabBar(
            controller: controller.tabController,
            indicatorSize: TabBarIndicatorSize.label,
            indicatorPadding: const EdgeInsets.symmetric(vertical: 10),
            indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: AppThemeData.secondaryColor),
            labelPadding: const EdgeInsets.symmetric(horizontal: 5),
            labelColor: AppThemeData.primaryColor,
            unselectedLabelColor: Colors.white,
            tabs: activity.subactivityPreviews
                .map(
                  (it) => Tab(
                    child: Text(it.name)
                        .fontSize(16)
                        .textAlignment(TextAlign.center)
                        .paddingSymmetric(horizontal: 10),
                  ),
                )
                .toList(),
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
        );
        final tabBarView = TabBarView(
          controller: controller.tabController,
          children: activity.subactivityPreviews.map((it) {
            return SubactivityView(
              id: it.id,
              headerIsExpanded: controller.headerIsExpanded.value,
              headerShouldExpandCallback: (shouldExpand) {
                controller.headerIsExpanded.value = shouldExpand;
              },
            );
          }).toList(),
        );
        return Column(
          children: [
            AnimatedSize(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              child: controller.headerIsExpanded.value
                  ? Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        title,
                        issuer,
                      ],
                    )
                  : const SizedBox(height: 0),
            ),
            tabBar,
            divider,
            Expanded(child: tabBarView),
          ],
        );
      },
    );
  }
}
