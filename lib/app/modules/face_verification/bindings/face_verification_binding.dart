// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/app/modules/face_verification/controllers/face_verification_controller.dart';
import 'package:blockie_app/data/repositories/account_repository.dart';

class FaceVerificationBinding implements Bindings {
  FaceVerificationBinding({
    required this.accountRepository,
  });

  final AccountRepository accountRepository;

  @override
  void dependencies() {
    Get.lazyPut(
      () => FaceVerificationController(
        repository: accountRepository,
      ),
    );
  }
}
