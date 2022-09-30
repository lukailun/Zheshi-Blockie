import 'package:get/get.dart';
import 'package:blockie_app/app/modules/face_verification/controllers/face_verification_controller.dart';
import 'package:blockie_app/data/repositories/account_repository.dart';
import 'package:blockie_app/utils/http_request.dart';

class FaceVerificationBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FaceVerificationController(
        repository: AccountRepository(client: HttpRequest())));
  }
}