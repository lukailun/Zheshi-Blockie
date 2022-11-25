// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/app/modules/gallery/controllers/gallery_controller.dart';
import 'package:blockie_app/data/models/app_theme_data.dart';
import 'package:blockie_app/widgets/basic_app_bar.dart';

class GalleryView extends GetView<GalleryController> {
  const GalleryView({super.key});

  @override
  Widget build(BuildContext context) {
    final pageView = PageView.builder(
      itemCount: controller.imageUrls.length,
      controller: controller.pageController,
      itemBuilder: (_, index) {
        return CachedNetworkImage(
          imageUrl: controller.imageUrls[index],
          fit: BoxFit.contain,
        );
      },
      onPageChanged: (index) {
        controller.currentIndex.value = index;
      },
    );

    return Obx(
      () {
        final appBar = BasicAppBar(
            title:
                '${controller.currentIndex.value + 1}/${controller.imageUrls.length}');
        return Scaffold(
          backgroundColor: AppThemeData.primaryColor,
          appBar: appBar,
          body: Column(
            children: [
              Expanded(
                child: Center(
                  child: pageView,
                ),
              ),
              SizedBox(
                height: appBar.toolbarHeight,
              ),
            ],
          ),
        );
      },
    );
  }
}
