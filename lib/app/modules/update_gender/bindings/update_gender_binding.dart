// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/app/modules/update_gender/controllers/update_gender_controller.dart';
import 'package:blockie_app/data/repositories/account_repository.dart';

class UpdateGenderBinding implements Bindings {
  final AccountRepository accountRepository;

  UpdateGenderBinding({
    required this.accountRepository,
  });

  @override
  void dependencies() {
    Get.lazyPut(
      () => UpdateGenderController(
        accountRepository: accountRepository,
      ),
    );
  }
}
