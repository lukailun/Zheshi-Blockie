// Flutter imports:
import 'package:blockie_app/app/modules/activities/views/activities_item_view.dart';
import 'package:blockie_app/models/environment.dart';
import 'package:dio_log/overlay_draggable_button.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/app/modules/activities/controllers/activities_controller.dart';
import 'package:blockie_app/app/modules/activities/models/activity.dart';
import 'package:blockie_app/extensions/extensions.dart';
import 'package:blockie_app/models/user_info.dart';
import 'package:blockie_app/widgets/basic_app_bar.dart';
import 'package:blockie_app/widgets/loading_indicator.dart';

class ActivitiesContainerView extends GetView<ActivitiesController> {
  const ActivitiesContainerView({super.key});

  @override
  Widget build(BuildContext context) {
    if (Environment.isDevelopment) {
      showDebugBtn(context);
    }
    return GetRouterOutlet.builder(
      routerDelegate: Get.rootDelegate,
      builder: (context, delegate, currentRoute) {
        return Obx(
          () => Scaffold(
            backgroundColor: Colors.transparent,
            appBar: BasicAppBar(
              showsLogo: true,
              avatar: _getAvatar(
                user: controller.user.value,
                avatarOnTap: controller.avatarOnTap,
              ),
            ),
            body: () {
              final activitiesValue = controller.activities.value;
              if (activitiesValue == null) {
                return const LoadingIndicator();
              } else {
                return _ActivitiesView(
                  activities: activitiesValue,
                  itemOnTap: (id) => controller.goToActivity(delegate, id),
                  issuerOnTap: controller.goToBrandDetails,
                );
              }
            }(),
          ),
        );
      },
    );
  }

  Widget _getAvatar({UserInfo? user, Function()? avatarOnTap}) {
    return Column(
      children: [
        const Spacer(flex: 1),
        GestureDetector(
          onTap: avatarOnTap,
          child: SizedBox(
            width: 50,
            height: 50,
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(25)),
              child: AspectRatio(
                aspectRatio: 1,
                child: Visibility(
                  visible: user != null,
                  replacement: Container(
                    color: Colors.grey,
                    alignment: Alignment.center,
                    width: 50,
                    height: 50,
                    child: const Text('登录')
                        .textColor(const Color(0xb3FFFFFF))
                        .fontSize(14),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: user?.avatarUrl ?? '',
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        ),
        const Spacer(flex: 1),
      ],
    ).paddingOnly(right: 10);
  }
}

class _ActivitiesView extends StatelessWidget {
  final List<Activity> activities;
  final Function(String)? itemOnTap;
  final Function(String)? issuerOnTap;

  const _ActivitiesView({
    required this.activities,
    this.itemOnTap,
    this.issuerOnTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: activities.length,
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 8),
      separatorBuilder: (context, index) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        final activity = activities[index];
        return ActivitiesItemView(
          activity: activity,
          issuerOnTap: () =>
              issuerOnTap?.call(activities[index].issuer?.id ?? ''),
          onTap: () => itemOnTap?.call(activities[index].id),
        );
      },
    );
  }
}
