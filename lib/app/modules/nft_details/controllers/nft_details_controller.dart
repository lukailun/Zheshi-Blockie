// Dart imports:
import 'dart:async';
import 'dart:html' as html;

// Package imports:
import 'package:blockie_app/app/routes/app_router.dart';
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/app/modules/brand_details/controllers/brand_details_controller.dart';
import 'package:blockie_app/app/modules/profile/controllers/profile_controller.dart';
import 'package:blockie_app/app/modules/share/controllers/share_controller.dart';
import 'package:blockie_app/app/routes/app_pages.dart';
import 'package:blockie_app/data/models/nft_details.dart';
import 'package:blockie_app/data/models/wechat_share_source.dart';
import 'package:blockie_app/data/models/wechat_shareable.dart';
import 'package:blockie_app/data/repositories/project_repository.dart';
import 'package:blockie_app/services/auth_service.dart';

part 'nft_details_controller_router.dart';

StreamSubscription<html.MessageEvent>? nftDetailsSubscription;

class NftDetailsController extends GetxController with WechatShareable {
  NftDetailsController({
    required this.projectRepository,
  });

  final ProjectRepository projectRepository;
  final id = Get.parameters[NftDetailsParameter.id] as String;

  final nftDetails = Rxn<NftDetails>();

  @override
  void onReady() {
    super.onReady();
    getNftDetails();
  }

  @override
  void onClose() {
    super.onClose();
    nftDetailsSubscription?.cancel();
    nftDetailsSubscription = null;
    isDefaultConfig = true;
  }

  void getNftDetails() async {
    nftDetails.value = await projectRepository.getNftDetails(id);
    final details = nftDetails.value;
    if (details == null) {
      return;
    }
    isDefaultConfig = false;
  }

  @override
  String description() {
    final nftDetailsValue = nftDetails.value;
    if (nftDetailsValue == null) {
      return WechatShareSource.defaults.getDescription();
    }
    return isDefaultConfig
        ? WechatShareSource.defaults.getTitle()
        : (nftDetailsValue.subactivity.shareDescription.isNotEmpty
            ? nftDetailsValue.subactivity.shareDescription
            : WechatShareSource.nft.getDescription(
                extraInfo: nftDetailsValue.benefit.description));
  }

  @override
  String imageUrl() {
    final nftDetailsValue = nftDetails.value;
    if (nftDetailsValue == null) {
      return WechatShareSource.defaults.getImageUrl();
    }
    return isDefaultConfig
        ? WechatShareSource.defaults.getTitle()
        : WechatShareSource.nft
            .getImageUrl(extraInfo: nftDetailsValue.coverUrl);
  }

  @override
  String link() {
    final nftDetailsValue = nftDetails.value;
    if (nftDetailsValue == null) {
      return WechatShareSource.defaults.getImageUrl();
    }
    return isDefaultConfig
        ? WechatShareSource.defaults.getLink()
        : WechatShareSource.nft.getLink(
            extraInfo: '${NftDetailsParameter.id}=${nftDetailsValue.id}');
  }

  @override
  String title() {
    final nftDetailsValue = nftDetails.value;
    if (nftDetailsValue == null) {
      return WechatShareSource.defaults.getTitle();
    }
    return isDefaultConfig
        ? WechatShareSource.defaults.getTitle()
        : (nftDetailsValue.subactivity.shareTitle.isNotEmpty
            ? nftDetailsValue.subactivity.shareTitle
            : WechatShareSource.nft
                .getTitle(extraInfo: nftDetailsValue.benefit.name));
  }
}

class NftDetailsParameter {
  static const id = 'uid';
}
