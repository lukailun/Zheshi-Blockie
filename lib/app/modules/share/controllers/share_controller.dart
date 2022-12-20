// Flutter imports:
import 'package:blockie_app/data/repositories/common_repository.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/app/modules/share//models/share_type.dart';
import 'package:blockie_app/app/modules/share/models/share_info.dart';
import 'package:blockie_app/app/modules/share/models/share_info_item.dart';
import 'package:blockie_app/data/repositories/project_repository.dart';
import 'package:blockie_app/extensions/extensions.dart';

part 'share_controller_router.dart';

class ShareController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final ProjectRepository projectRepository;
  final CommonRepository commonRepository;

  ShareController({
    required this.projectRepository,
    required this.commonRepository,
  });

  final items = <ShareInfoItem>[].obs;
  final selectedIndex = 0.obs;
  final shareInfo = Rxn<ShareInfo>();
  final isShowingWechatMiniProgramQrCode = false.obs;
  final videoDownloadBase64String = Rxn<String>();
  TabController? tabController;

  final id = Get.parameters[ShareParameter.id] ?? '';
  final isNft = (Get.parameters[ShareParameter.isNft] ?? '').parseBool();

  bool get isVideo => items.value.isNotEmpty
      ? items.value[selectedIndex.value].id == ShareType.videoId
      : false;

  @override
  void onReady() {
    super.onReady();
    if (isNft) {
      getNFTDetailsShareInfo();
    } else {
      getProjectDetailsShareInfo();
    }
  }

  void handleHintViewTap() async {
    if (!isVideo) {
      return;
    }
    isShowingWechatMiniProgramQrCode.value =
        !isShowingWechatMiniProgramQrCode.value;
  }

  void getProjectDetailsShareInfo() async {
    shareInfo.value = await projectRepository.getProjectDetailsShareInfo(id);
    setupTabBars();
    getWechatMiniProgramCode();
  }

  void getNFTDetailsShareInfo() async {
    shareInfo.value = await projectRepository.getNFTDetailsShareInfo(id);
    setupTabBars();
    getWechatMiniProgramCode();
  }

  void getWechatMiniProgramCode() async {
    if (items.value.where((it) => it.id == ShareType.videoId).isEmpty) {
      return;
    }
    final code = await commonRepository.getWechatMiniProgramCode(id);
    videoDownloadBase64String.value = code?.base64String;
  }

  void setupTabBars() {
    items.value = [];
    final shareInfoValue = shareInfo.value;
    if (shareInfoValue == null) {
      return;
    }
    if (isNft) {
      if (shareInfoValue.posterUrl != null) {
        if ((shareInfoValue.video?.url ?? '').isNotEmpty) {
          items.value.add(ShareInfoItem(
            id: ShareType.video.id,
            title: ShareType.video.title,
            imageUrl: shareInfoValue.posterUrl ?? '',
            video: shareInfoValue.video,
          ));
        }
        items.value.add(ShareInfoItem(
          id: ShareType.info.id,
          title: ShareType.info.title,
          imageUrl: shareInfoValue.posterUrl ?? '',
        ));
      }
      if (shareInfoValue.imageUrl != null) {
        items.value.add(ShareInfoItem(
          id: ShareType.image.id,
          title: ShareType.image.title,
          imageUrl: shareInfoValue.imageUrl ?? '',
        ));
      }
    } else {
      if (shareInfoValue.posterUrl != null) {
        items.value.add(ShareInfoItem(
          id: ShareType.poster.id,
          title: ShareType.poster.title,
          imageUrl: shareInfoValue.posterUrl ?? '',
        ));
      }
      if (shareInfoValue.imageUrl != null) {
        items.value.add(ShareInfoItem(
          id: ShareType.image.id,
          title: ShareType.image.title,
          imageUrl: shareInfoValue.imageUrl ?? '',
        ));
      }
    }
    tabController = TabController(length: items.value.length, vsync: this)
      ..addListener(() {
        selectedIndex.value = tabController?.index ?? 0;
      });
  }
}

class ShareParameter {
  static const id = 'id';
  static const isNft = 'isNft';
}
