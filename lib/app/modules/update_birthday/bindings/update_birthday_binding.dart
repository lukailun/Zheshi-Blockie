// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/app/modules/update_birthday/controllers/update_birthday_controller.dart';
import 'package:blockie_app/data/repositories/account_repository.dart';

class UpdateBirthdayBinding implements Bindings {
  final AccountRepository accountRepository;

  UpdateBirthdayBinding({
    required this.accountRepository,
  });

  @override
  void dependencies() {
    Get.lazyPut(
      () => UpdateBirthdayController(
        accountRepository: accountRepository,
      ),
    );
  }
}
