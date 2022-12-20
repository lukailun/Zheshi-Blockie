// Package imports:
import 'package:blockie_app/app/modules/web_view/controllers/web_view_controller.dart';
import 'package:blockie_app/app/routes/app_router.dart';
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/app/routes/app_pages.dart';
import 'package:blockie_app/data/apis/blockie_api/blockie_url_builder.dart';
import 'package:blockie_app/data/repositories/account_repository.dart';
import 'package:blockie_app/widgets/message_toast.dart';

part 'face_verification_controller_router.dart';

class FaceVerificationController extends GetxController {
  final AccountRepository repository;

  FaceVerificationController({required this.repository});

  final isTakingPhoto = false.obs;

  void uploadFacePhoto(List<int> bytes, String filename) async {
    final faceInfo = await repository.uploadFacePhoto(bytes, filename);
    isTakingPhoto.value = false;
    if (faceInfo != null) {
      MessageToast.showMessage("上传成功");
      Get.back(result: true);
    } else {
      MessageToast.showMessage("上传失败");
    }
  }
}
