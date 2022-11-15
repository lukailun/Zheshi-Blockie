import 'package:blockie_app/app/modules/activities/views/activities_item_view.dart';
import 'package:blockie_app/extensions/extensions.dart';
import 'package:blockie_app/widgets/basic_app_bar.dart';
import 'package:blockie_app/widgets/loading_indicator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:blockie_app/app/modules/brand_details/controllers/brand_details_controller.dart';

class BrandDetailsView extends GetView<BrandDetailsController> {
  const BrandDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: Colors.transparent,
        appBar: BasicAppBar(),
        body: () {
          final issuer = controller.issuer.value;
          final activities = controller.activities.value;
          if (issuer == null || activities == null) {
            return const LoadingIndicator();
          }
          final brand = Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(36)),
                  child: CachedNetworkImage(
                    imageUrl: issuer.logoUrl ?? '',
                    width: 72,
                    height: 72,
                  ),
                ),
              ),
              Center(
                child: Text(issuer.title)
                    .textColor(Colors.white)
                    .fontSize(16)
                    .paddingSymmetric(vertical: 10),
              ),
              Visibility(
                visible: (issuer.summary ?? '').isNotEmpty,
                child: Center(
                  child: Text(issuer.summary ?? '')
                      .textColor(const Color(0xCCFFFFFF))
                      .fontSize(14)
                      .textAlignment(TextAlign.center),
                ).paddingAll(15).outlined().paddingOnly(bottom: 22),
              ),
            ],
          );
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 22),
            child: Column(
              children: [
                brand,
                Row(
                  children: [
                    const Text("品牌项目").textColor(Colors.white).fontSize(16),
                    const Spacer(flex: 1),
                    Text("共 ${activities.length} 个")
                        .textColor(Colors.white)
                        .fontSize(16),
                  ],
                ).paddingSymmetric(vertical: 12),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final activity = activities[index];
                    return ActivitiesItemView(
                      activity: activity,
                      onTap: () => controller.goToActivity(activity.id),
                    );
                  },
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 8),
                  itemCount: activities.length,
                ),
              ],
            ),
          );
        }(),
      ),
    );

    // Widget brandCards = SizedBox(
    //   child: ListView.builder(
    //       itemCount: _projectGroups.length + 1,
    //       shrinkWrap: true,
    //       physics: const ClampingScrollPhysics(),
    //       itemBuilder: (context, index) {
    //         //如果到了表尾
    //         if (index == _projectGroups.length) {
    //           if (_nextPageUrl != null) {
    //             _addProjects();
    //             return Container(
    //               // padding: const EdgeInsets.all(16.0),
    //               alignment: Alignment.center,
    //               child: const SizedBox(
    //                 width: 24.0,
    //                 height: 24.0,
    //                 child: CircularProgressIndicator(strokeWidth: 2.0),
    //               ),
    //             );
    //           } else {
    //             return Container(
    //               alignment: Alignment.center,
    //               // padding: const EdgeInsets.all(16.0),
    //               child: const Text(
    //                 "没有更多了",
    //                 style: TextStyle(color: Colors.grey),
    //               ).paddingOnly(bottom: 15),
    //             );
    //           }
    //         }
    //         return createProjectItemMixed(_projectGroups[index],
    //             showBrand: false);
    //       }),
    // );
    //
    // return Scaffold(
    //   backgroundColor: Colors.transparent,
    //   appBar: BasicAppBar(),
    //   body: ListView(
    //     shrinkWrap: true,
    //     padding: const EdgeInsets.symmetric(horizontal: 20),
    //     children: [
    //       brandInfo,
    //       brandIntro,
    //       brandCardTitle,
    //       brandCards,
    //     ],
    //   ),
    // );
  }
}
