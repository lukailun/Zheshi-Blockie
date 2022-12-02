// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/app/modules/update_bio/controllers/update_bio_controller.dart';
import 'package:blockie_app/data/repositories/account_repository.dart';

class UpdateBioBinding implements Bindings {
  final AccountRepository accountRepository;

  UpdateBioBinding({
    required this.accountRepository,
  });

  @override
  void dependencies() {
    Get.lazyPut(
      () => UpdateBioController(
        accountRepository: accountRepository,
      ),
    );
  }
}
