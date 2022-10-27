// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/app/modules/profile/controllers/profile_controller.dart';
import 'package:blockie_app/data/repositories/account_repository.dart';

class ProfileBinding implements Bindings {
  ProfileBinding({required AccountRepository accountRepository})
      : _accountRepository = accountRepository;

  final AccountRepository _accountRepository;

  @override
  void dependencies() {
    Get.lazyPut(
      () => ProfileController(
        repository: _accountRepository,
      ),
    );
  }
}
