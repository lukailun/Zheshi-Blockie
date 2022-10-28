// Dart imports:
import 'dart:ui';

// Flutter imports:
import 'package:blockie_app/app/modules/share/models/share_type.dart';
import 'package:blockie_app/data/repositories/project_repository.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/extensions/extensions.dart';
import 'package:blockie_app/models/app_theme_data.dart';
import 'package:blockie_app/widgets/html_image.dart';
import 'package:blockie_app/widgets/segmented_control/segmented_control.dart';

extension GetDialogExtension on GetInterface {
  // void shareDialog({
  //   required ProjectRepository repository,
  //   required String id,
  //   required bool isNft,
  //   Function()? onBack,
  // }) {
  //   Get.dialog(
  //     ShareDialog(
  //       repository: repository,
  //       id: id,
  //       isNft: isNft,
  //       onBack: onBack,
  //     ),
  //     barrierColor: AppThemeData.barrierColor,
  //     barrierDismissible: false,
  //   );
  // }
}

class ShareDialog extends StatefulWidget {
  final ProjectRepository repository;
  final String id;
  final bool isNft;
  final Function()? onBack;

  const ShareDialog({
    super.key,
    required this.repository,
    required this.id,
    required this.isNft,
    this.onBack,
  });

  @override
  State<ShareDialog> createState() => _ShareDialogState();
}

class _ShareDialogState extends State<ShareDialog> {
  List<SegmentedControlButtonItem> _segmentedControlItems =
      <SegmentedControlButtonItem>[];
  final _selectedIndex = 0.obs;
  final _posterPath = "".obs;
  final _path = "".obs;

  @override
  void initState() {
    super.initState();
    const info = ShareType.info;
    const image = ShareType.image;
    const poster = ShareType.poster;
    if (widget.isNft) {
      _segmentedControlItems = [
        SegmentedControlButtonItem(ID: info.ID, title: info.title),
        SegmentedControlButtonItem(ID: image.ID, title: image.title),
      ];
      _getNFTDetailsShareInfo();
    } else {
      _segmentedControlItems = [
        SegmentedControlButtonItem(ID: poster.ID, title: poster.title),
      ];
      _getProjectDetailsShareInfo();
    }
  }

  @override
  Widget build(BuildContext context) {
    final segmentedControl = SegmentedControl(
      items: _segmentedControlItems,
      selectedIndex: _selectedIndex.value,
      onSegmentSelected: (index) {
        _selectedIndex.value = index;
      },
    ).paddingOnly(top: 22, left: 56, right: 56);
    final saveHintView = Container(
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
      child: Center(
        child: const Text('长按图片保存')
            .textColor(Colors.white)
            .fontSize(14)
            .fontWeight(FontWeightCompat.regular),
      ),
    );
    return Obx(
      () => BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Stack(
          children: [
            Column(
              children: [
                segmentedControl,
                Expanded(
                  child: Center(
                    child: () {
                      final imageUrl = _selectedIndex.value == 0
                          ? _posterPath.value.hostAdded
                          : _path.value.hostAdded;
                      return Stack(
                        children: [
                          Center(
                            child: CachedNetworkImage(
                              imageUrl: imageUrl,
                              fit: BoxFit.contain,
                            ).paddingAll(30),
                          ),
                          Opacity(
                            opacity: 0.01,
                            child: Opacity(
                              opacity: 0.01,
                              alwaysIncludeSemantics: true,
                              child: HtmlImage(url: imageUrl).paddingAll(30),
                            ),
                          ),
                        ],
                      );
                    }(),
                  ),
                ),
                saveHintView,
              ],
            ),
            GestureDetector(
              onTap: () {
                Get.back();
                widget.onBack?.call();
              },
              child: Image.asset(
                "images/app_bar/back.png",
                width: 34,
                height: 34,
              ),
            ).paddingOnly(top: 22, left: 22),
          ],
        ),
      ),
    );
  }

  void _getProjectDetailsShareInfo() async {
    final shareInfo =
        await widget.repository.getProjectDetailsShareInfo(widget.id);
    _posterPath.value = shareInfo.posterPath;
    _path.value = shareInfo.path;
  }

  void _getNFTDetailsShareInfo() async {
    final shareInfo = await widget.repository.getNFTDetailsShareInfo(widget.id);
    _posterPath.value = shareInfo.posterPath;
    _path.value = shareInfo.path;
  }
}
