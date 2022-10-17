// Package imports:
import 'package:blockie_app/services/wechat_service/wechat_service.dart';
import 'package:blockie_app/services/wechat_service/wechat_share_source.dart';
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/app/modules/share//models/share_type.dart';
import 'package:blockie_app/data/repositories/project_repository.dart';
import 'package:blockie_app/extensions/get_extension.dart';
import 'package:blockie_app/widgets/segmented_control/segmented_control.dart';

class ShareController extends GetxController {
  final ProjectRepository repository;

  ShareController({required this.repository});

  List<SegmentedControlButtonItem> segmentedControlItems =
      <SegmentedControlButtonItem>[];
  final selectedIndex = 0.obs;
  final posterPath = "".obs;
  final path = "".obs;

  final String _ID = Get.jsonParameters[ShareParameter.ID];
  final bool _isNFT = Get.jsonParameters[ShareParameter.isNFT];
  final String _title = Get.jsonParameters[ShareParameter.title];
  final String _description = Get.jsonParameters[ShareParameter.description];
  final String _imageUrl = Get.jsonParameters[ShareParameter.imageUrl];

  @override
  void onInit() {
    super.onInit();
    const info = ShareType.info;
    const image = ShareType.image;
    const poster = ShareType.poster;
    if (_isNFT) {
      _getNFTDetailsShareInfo();
      segmentedControlItems = [
        SegmentedControlButtonItem(ID: info.ID, title: info.title),
        SegmentedControlButtonItem(ID: image.ID, title: image.title),
      ];
      final shareTitle = WechatShareSource.NFT.getTitle(extraInfo: _title);
      final shareDescription =
          WechatShareSource.NFT.getDescription(extraInfo: _description);
      final shareImageUrl =
          WechatShareSource.NFT.getImageUrl(extraInfo: _imageUrl);
      WechatService.to.updateShareInfo(
        title: shareTitle,
        description: shareDescription,
        imageUrl: shareImageUrl,
      );
    } else {
      _getProjectDetailsShareInfo();
      segmentedControlItems = [
        SegmentedControlButtonItem(ID: poster.ID, title: poster.title),
      ];
      final shareTitle = WechatShareSource.event.getTitle(extraInfo: _title);
      final shareDescription =
          WechatShareSource.event.getDescription(extraInfo: _description);
      final shareImageUrl =
          WechatShareSource.event.getImageUrl(extraInfo: _imageUrl);
      WechatService.to.updateShareInfo(
        title: shareTitle,
        description: shareDescription,
        imageUrl: shareImageUrl,
      );
    }
  }

  void _getProjectDetailsShareInfo() async {
    final shareInfo = await repository.getProjectDetailsShareInfo(_ID);
    posterPath.value = shareInfo.posterPath;
    path.value = shareInfo.path;
  }

  void _getNFTDetailsShareInfo() async {
    final shareInfo = await repository.getNFTDetailsShareInfo(_ID);
    posterPath.value = shareInfo.posterPath;
    path.value = shareInfo.path;
  }
}

class ShareParameter {
  static const ID = "ID";
  static const isNFT = "isNFT";
  static const title = "title";
  static const description = "description";
  static const imageUrl = "imageUrl";
}
