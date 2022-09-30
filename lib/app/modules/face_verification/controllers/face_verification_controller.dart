import 'dart:typed_data';
import 'package:blockie_app/widgets/message_toast.dart';
import 'package:get/get.dart';
import 'package:blockie_app/data/repositories/account_repository.dart';

class FaceVerificationController extends GetxController {
  final AccountRepository repository;

  FaceVerificationController({required this.repository});

  void uploadFacePhoto(List<int> bytes, String filename) async {
    final faceInfo = await repository.uploadFacePhoto(bytes, filename);
    if (faceInfo != null) {
      MessageToast.showMessage("上传成功");
      Get.back(result: true);
    } else {
      MessageToast.showMessage("上传失败");
    }
  }
}
