// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/app/modules/update_region/controllers/update_region_controller.dart';
import 'package:blockie_app/data/repositories/account_repository.dart';
import 'package:blockie_app/data/repositories/common_repository.dart';

class UpdateRegionBinding implements Bindings {
  final AccountRepository accountRepository;
  final CommonRepository commonRepository;

  UpdateRegionBinding({
    required this.accountRepository,
    required this.commonRepository,
  });

  @override
  void dependencies() {
    Get.lazyPut(
      () => UpdateRegionController(
        accountRepository: accountRepository,
        commonRepository: commonRepository,
      ),
    );
  }
}
