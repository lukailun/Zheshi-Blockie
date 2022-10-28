// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/app/modules/share//models/share_type.dart';
import 'package:blockie_app/data/repositories/project_repository.dart';
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

  @override
  void onInit() {
    super.onInit();
    const info = ShareType.info;
    const image = ShareType.image;
    const poster = ShareType.poster;
    if (_isNFT == 'true') {
      segmentedControlItems = [
        SegmentedControlButtonItem(ID: info.ID, title: info.title),
        SegmentedControlButtonItem(ID: image.ID, title: image.title),
      ];
    } else {
      segmentedControlItems = [
        SegmentedControlButtonItem(ID: poster.ID, title: poster.title),
      ];
    }
  }

  @override
  void onReady() {
    super.onReady();
    if (_isNFT == 'true') {
      _getNFTDetailsShareInfo();
    } else {
      _getProjectDetailsShareInfo();
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
}
