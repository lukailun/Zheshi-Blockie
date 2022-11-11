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
          if (issuer == null) {
            return const LoadingIndicator();
          }
          final brand = Column(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(36)),
                child: CachedNetworkImage(
                  imageUrl: issuer.avatarUrl,
                  width: 72,
                  height: 72,
                ),
              ),
              Text(issuer.name)
                  .textColor(Colors.white)
                  .fontSize(16)
                  .paddingSymmetric(vertical: 10),
            ],
          );
          return brand;
        }(),
      ),
    );

    // Widget brandInfo = Column(
    //   children: [
    //     CircleAvatar(
    //       radius: 36,
    //       backgroundImage: NetworkImage(
    //           _issuerInfo == null ? '' : _issuerInfo!.logoUrl ?? ''),
    //     ),
    //     Container(
    //       padding: const EdgeInsets.only(top: 7, bottom: 11),
    //       child: Text(
    //         _issuerInfo == null ? '' : _issuerInfo!.title,
    //         style: const TextStyle(color: Color(0xffffffff), fontSize: 16),
    //       ),
    //     )
    //   ],
    // );

    // Widget brandIntro = Center(
    //   child: Text(
    //     _issuerInfo!.summary,
    //     textAlign: TextAlign.center,
    //     style: const TextStyle(color: Color(0xccffffff), fontSize: 14),
    //   ),
    // ).paddingAll(15).outlined().paddingOnly(bottom: 22);
    //
    // const projectTitleStyle = TextStyle(color: Color(0xffffffff), fontSize: 16);
    //
    // Widget brandCardTitle = Container(
    //   padding: const EdgeInsets.only(bottom: 8, top: 22),
    //   child: Row(
    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //     children: [
    //       const Text(
    //         "品牌项目",
    //         style: projectTitleStyle,
    //       ),
    //       Text(
    //         "共${_projectGroups.length}个",
    //         style: projectTitleStyle,
    //       )
    //     ],
    //   ),
    // );
    //
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
