// Dart imports:
import 'dart:ui';

// Flutter imports:
import 'package:blockie_app/widgets/basic_app_bar.dart';
import 'package:blockie_app/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/app/modules/share/controllers/share_controller.dart';
import 'package:blockie_app/extensions/extensions.dart';
import 'package:blockie_app/models/app_theme_data.dart';
import 'package:blockie_app/widgets/html_image.dart';

class ShareView extends GetView<ShareController> {
  const ShareView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        final shareInfo = controller.shareInfo.value;
        if (shareInfo == null) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: BasicAppBar(),
            body: const LoadingIndicator(color: AppThemeData.primaryColor),
          );
        }
        final tabBar = Theme(
          data: ThemeData(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
          child: TabBar(
            controller: controller.tabController,
            indicatorSize: TabBarIndicatorSize.label,
            indicatorColor: AppThemeData.primaryColor,
            indicatorPadding: const EdgeInsets.symmetric(horizontal: 30),
            labelColor: AppThemeData.primaryColor,
            unselectedLabelColor: const Color(0xFF8F8F8F),
            tabs: controller.items.value
                .map(
                  (it) => Tab(
                    child: Text(it.title)
                        .fontSize(15)
                        .fontWeight(FontWeightCompat.semiBold)
                        .textAlignment(TextAlign.center)
                        .paddingSymmetric(horizontal: 10),
                  ),
                )
                .toList(),
          ),
        );
        final saveHintView = GestureDetector(
          onTap: controller.handleHintViewTap,
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0x00202020),
                  AppThemeData.primaryColor,
                ],
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              color: AppThemeData.primaryColor,
            ),
            width: double.infinity,
            height: 76,
            child: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Center(
                  child: Text(controller.isVideo ? '点击复制链接 到默认浏览器下载' : '长按图片保存')
                      .textColor(Colors.white)
                      .fontSize(14)
                      .fontWeight(FontWeightCompat.regular),
                ),
              ),
            ),
          ),
        );
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: BasicAppBar(titleView: tabBar),
          body: Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.white,
            child: Obx(
              () => Column(
                children: [
                  Expanded(
                    child: TabBarView(
                      controller: controller.tabController,
                      children: controller.items.value.map((it) {
                        return Center(
                          child: HtmlImage(url: it.imageUrl).paddingAll(30),
                        );
                      }).toList(),
                    ),
                  ),
                  saveHintView,
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
