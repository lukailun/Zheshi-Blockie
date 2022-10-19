// Dart imports:
import 'dart:html' as html;

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/app/modules/share//models/share_type.dart';
import 'package:blockie_app/data/apis/models/wechat_share_source.dart';
import 'package:blockie_app/data/repositories/project_repository.dart';
import 'package:blockie_app/services/wechat_service/wechat_service.dart';
import 'package:blockie_app/widgets/segmented_control/segmented_control.dart';

class ShareController extends GetxController {
  final ProjectRepository repository;

  ShareController({required this.repository});

  List<SegmentedControlButtonItem> segmentedControlItems =
      <SegmentedControlButtonItem>[];
  final selectedIndex = 0.obs;
  final posterPath = "".obs;
  final path = "".obs;

  final _id = Get.parameters[ShareParameter.id] ?? '';
  final _isNFT = Get.parameters[ShareParameter.isNFT] ?? '';
  final _title = Get.parameters[ShareParameter.shareTitle] ?? '';
  final _description = Get.parameters[ShareParameter.shareDescription] ?? '';
  final _imageUrl = Get.parameters[ShareParameter.shareImageUrl] ?? '';

  @override
  void onReady() {
    super.onReady();
    const info = ShareType.info;
    const image = ShareType.image;
    const poster = ShareType.poster;
    if (_isNFT == 'true') {
      _getNFTDetailsShareInfo();
      segmentedControlItems = [
        SegmentedControlButtonItem(ID: info.ID, title: info.title),
        SegmentedControlButtonItem(ID: image.ID, title: image.title),
      ];
      final shareTitle = WechatShareSource.nft.getTitle(extraInfo: _title);
      final shareDescription =
          WechatShareSource.nft.getDescription(extraInfo: _description);
      final shareLink = html.window.location.href;
      final shareImageUrl =
          WechatShareSource.nft.getImageUrl(extraInfo: _imageUrl);
      WechatService.to.updateShareConfig(
        title: shareTitle,
        description: shareDescription,
        link: shareLink,
        imageUrl: shareImageUrl,
      );
    } else {
      _getProjectDetailsShareInfo();
      segmentedControlItems = [
        SegmentedControlButtonItem(ID: poster.ID, title: poster.title),
      ];
      final shareTitle = WechatShareSource.activity.getTitle(extraInfo: _title);
      final shareDescription =
          WechatShareSource.activity.getDescription(extraInfo: _description);
      final shareLink = html.window.location.href;
      final shareImageUrl =
          WechatShareSource.activity.getImageUrl(extraInfo: _imageUrl);
      WechatService.to.updateShareConfig(
        title: shareTitle,
        description: shareDescription,
        link: shareLink,
        imageUrl: shareImageUrl,
      );
    }
  }

  void _getProjectDetailsShareInfo() async {
    final shareInfo = await repository.getProjectDetailsShareInfo(_id);
    posterPath.value = shareInfo.posterPath;
    path.value = shareInfo.path;
  }

  void _getNFTDetailsShareInfo() async {
    final shareInfo = await repository.getNFTDetailsShareInfo(_id);
    posterPath.value = shareInfo.posterPath;
    path.value = shareInfo.path;
  }
}

class ShareParameter {
  static const id = "id";
  static const isNFT = "isNFT";
  static const shareTitle = "title";
  static const shareDescription = "description";
  static const shareImageUrl = "imageUrl";
}
