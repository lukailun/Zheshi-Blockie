// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/data/repositories/account_repository.dart';
import '../controllers/settings_controller.dart';

class SettingsBinding implements Bindings {
  SettingsBinding({required AccountRepository accountRepository})
      : _accountRepository = accountRepository;

  final AccountRepository _accountRepository;

  @override
  void dependencies() {
    Get.lazyPut(
      () => SettingsController(
        repository: _accountRepository,
      ),
    );
  }
}
