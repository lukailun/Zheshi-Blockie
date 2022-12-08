// Dart imports:
import 'dart:convert';
import 'dart:html' as html;
import 'dart:ui' as ui;

// Flutter imports:
import 'package:blockie_app/data/models/nft_paster_type.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:cached_network_image/cached_network_image.dart';
import 'package:chinese_number/chinese_number.dart';
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/app/modules/nft_details/controllers/nft_details_controller.dart';
import 'package:blockie_app/data/models/app_bar_button_item.dart';
import 'package:blockie_app/data/models/app_theme_data.dart';
import 'package:blockie_app/data/models/basic_details_card_item.dart';
import 'package:blockie_app/data/models/nft_details.dart';
import 'package:blockie_app/data/models/nft_type.dart';
import 'package:blockie_app/extensions/extensions.dart';
import 'package:blockie_app/widgets/basic_app_bar.dart';
import 'package:blockie_app/widgets/basic_details_card.dart';
import 'package:blockie_app/widgets/loading_indicator.dart';

class NftDetailsView extends GetView<NftDetailsController> {
  const NftDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final appBar = BasicAppBar(
        pointerIntercepting: true,
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
            ],
          ),
        ],
      );
      return Scaffold(
        backgroundColor: AppThemeData.primaryColor,
        extendBodyBehindAppBar: true,
        appBar: appBar,
        body: () {
          final nftDetails = controller.nftDetails.value;
          if (nftDetails == null) {
            return const LoadingIndicator();
          }
          final viewType = 'nft_details_${controller.id}';
          //ignore: undefined_prefixed_name
          ui.platformViewRegistry.registerViewFactory(viewType, (int viewId) {
            return html.IFrameElement()
              ..src = nftDetails.src
              ..style.width = '100%'
              ..style.height = '100%'
              ..style.border = 'none'
              ..onLoad.listen((event) async {
                nftDetailsSubscription?.cancel();
                nftDetailsSubscription = html.window.onMessage
                    .listen((html.MessageEvent messageEvent) {
                  final data = messageEvent.data;
                  final event = jsonDecode(data);
                  final status = event['status'];
                  final method = event['method'];
                  if (status == 'ok' && method == 'download') {
                    controller.goToShare();
                  }
                });
              });
          });
          final webView = SizedBox(
            width: Get.width,
            height: Get.height * 0.8,
            child: IgnorePointer(
              child: HtmlElementView(viewType: viewType),
            ),
          );
          final imageView = CachedNetworkImage(
            imageUrl: nftDetails.src,
            width: double.infinity,
            fit: BoxFit.contain,
          );
          final panel =
              nftDetails.nftType == NftType.image ? imageView : webView;
          final title = Text(nftDetails.benefit.name)
              .fontSize(20)
              .textColor(Colors.white)
              .paddingOnly(left: 22, right: 22, bottom: 8);

          final brand = GestureDetector(
            onTap: () => controller.goToBrandDetails(nftDetails.issuer.id),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundImage: NetworkImage(
                    nftDetails.issuer.logoUrl ?? '',
                  ),
                ),
                Text(nftDetails.issuer.title)
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
                child: Text(nftDetails.mintedTime ?? '')
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
            nftDetails.benefit.description,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          )
              .textColor(const Color(0xCCFFFFFF))
              .paddingOnly(left: 25, right: 25, top: 6);

          final attributes = Visibility(
            visible: nftDetails.attributes.isNotEmpty,
            child: GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              crossAxisCount: 3,
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
              children: nftDetails.attributes
                  .map((it) => BasicDetailsCard(
                        items: [
                          BasicDetailsCardItem(title: it.key, content: it.value)
                        ],
                        paddingHorizontal: 10,
                        paddingVertical: 10,
                      ))
                  .toList(),
            ),
          ).paddingOnly(left: 44, right: 44, top: 21);

          final details = Stack(
            children: [
              BasicDetailsCard(items: nftDetails.items),
              Positioned(
                top: 0,
                right: 0,
                child: Visibility(
                  visible: nftDetails.pasterType != NftPasterType.undefined,
                  child: Container(
                    transform: Matrix4.translationValues(16.0, -16.0, 0.0),
                    child: Image.asset(
                      nftDetails.pasterType.assetName,
                      width: 96,
                      height: 96,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ],
          ).paddingOnly(left: 44, right: 44, top: 24, bottom: 20);
          final benefits = Visibility(
            visible: nftDetails.souvenirs.isNotEmpty,
            child: BasicDetailsCard(
                    items: nftDetails.souvenirs
                        .asMap()
                        .entries
                        .map((it) => BasicDetailsCardItem(
                            title:
                                '权益${(it.key + 1).toSimplifiedChineseNumber()}',
                            content: it.value.description))
                        .toList())
                .paddingOnly(left: 44, right: 44, bottom: 20),
          );
          return ListView(
            padding: const EdgeInsets.only(top: 0),
            children: [
              Stack(
                children: [
                  panel,
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      '${nftDetails.benefit.name} ${nftDetails.tokenId}',
                      maxLines: 2,
                    )
                        .textAlignment(TextAlign.center)
                        .textColor(const Color(0xFF666666))
                        .fontSize(19)
                        .paddingOnly(top: appBar.toolbarHeight),
                  ).paddingSymmetric(horizontal: 22),
                ],
              ),
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
                      attributes,
                      details,
                      benefits,
                    ],
                  ),
                ],
              ),
            ],
          );
        }(),
      );
    });
  }
}
