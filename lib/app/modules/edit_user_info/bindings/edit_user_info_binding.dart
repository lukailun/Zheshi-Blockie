// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/app/modules/edit_user_info/controllers/edit_user_info_controller.dart';
import 'package:blockie_app/data/repositories/account_repository.dart';

class EditUserInfoBinding implements Bindings {
  final AccountRepository accountRepository;

  EditUserInfoBinding({
    required this.accountRepository,
  });

  @override
  void dependencies() {
    Get.lazyPut(
      () => EditUserInfoController(
        accountRepository: accountRepository,
      ),
    );
  }
}
