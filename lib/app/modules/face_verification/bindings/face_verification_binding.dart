import 'package:get/get.dart';
import 'package:blockie_app/app/modules/face_verification/controllers/face_verification_controller.dart';

class FaceVerificationBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FaceVerificationController());
  }
}
