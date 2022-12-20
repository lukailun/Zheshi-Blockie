// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/app/modules/update_username/controllers/update_username_controller.dart';
import 'package:blockie_app/data/repositories/account_repository.dart';

class UpdateUsernameBinding implements Bindings {
  final AccountRepository accountRepository;

  UpdateUsernameBinding({
    required this.accountRepository,
  });

  @override
  void dependencies() {
    Get.lazyPut(
      () => UpdateUsernameController(
        accountRepository: accountRepository,
      ),
    );
  }
}
