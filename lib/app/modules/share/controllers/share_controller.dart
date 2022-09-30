import 'package:blockie_app/data/repositories/project_repository.dart';
import 'package:get/get.dart';

class ShareController extends GetxController {
  final ProjectRepository repository;

  ShareController({required this.repository});

  final selectedIndex = 0.obs;
  final posterPath = "".obs;
  final path = "".obs;

  final _ID = Get.parameters[ShareParameter.ID] ?? "";

  @override
  void onInit() {
    super.onInit();
    _getShareInfo();
  }

  void _getShareInfo() async {
    final shareInfo = await repository.getShareInfo(_ID);
    posterPath.value = shareInfo.posterPath;
    path.value = shareInfo.path;
  }
}

class ShareParameter {
  static const ID = "ID";
}
