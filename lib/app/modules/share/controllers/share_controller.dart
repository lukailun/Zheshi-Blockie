import 'package:blockie_app/data/repositories/project_repository.dart';
import 'package:get/get.dart';

class ShareController extends GetxController {
  final ProjectRepository repository;

  ShareController({required this.repository});

  final selectedIndex = 0.obs;
  final posterPath = "".obs;
  final path = "".obs;

  final _ID = Get.arguments[ShareParameter.ID] as String;
  final _isNFT = Get.arguments[ShareParameter.isNFT] as bool;

  @override
  void onInit() {
    super.onInit();
    _isNFT ? _getNFTDetailsShareInfo() : _getProjectDetailsShareInfo();
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
}
