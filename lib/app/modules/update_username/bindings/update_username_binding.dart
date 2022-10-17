// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/app/modules/update_username/controllers/update_username_controller.dart';
import 'package:blockie_app/data/repositories/account_repository.dart';
import 'package:blockie_app/utils/data_storage.dart';

class UpdateUsernameBinding implements Bindings {
  UpdateUsernameBinding({required AccountRepository accountRepository})
      : _accountRepository = accountRepository;

  final AccountRepository _accountRepository;

  @override
  void dependencies() {
    Get.lazyPut(
      () => UpdateUsernameController(
        repository: _accountRepository,
      ),
    );
  }
}
