// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/data/repositories/account_repository.dart';
import '../controllers/update_avatar_controller.dart';

class UpdateAvatarBinding implements Bindings {
  UpdateAvatarBinding({required this.accountRepository});

  final AccountRepository accountRepository;

  @override
  void dependencies() {
    Get.lazyPut(
      () => UpdateAvatarController(
        accountRepository: accountRepository,
      ),
    );
  }
}
