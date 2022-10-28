// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/app/modules/face_verification/controllers/face_verification_controller.dart';
import 'package:blockie_app/data/repositories/account_repository.dart';
import 'package:blockie_app/utils/http_request.dart';
import '../../../../data/apis/blockie_api.dart';
import '../../../../utils/data_storage.dart';

class FaceVerificationBinding implements Bindings {
  FaceVerificationBinding({required AccountRepository accountRepository})
      : _accountRepository = accountRepository;

  final AccountRepository _accountRepository;

  @override
  void dependencies() {
    Get.lazyPut(
      () => FaceVerificationController(
        repository: _accountRepository,
      ),
    );
  }
}
