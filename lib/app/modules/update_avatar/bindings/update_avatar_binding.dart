// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/data/repositories/account_repository.dart';
import 'package:blockie_app/utils/http_request.dart';
import '../../../../data/apis/blockie_api/blockie_api.dart';
import '../../../../utils/data_storage.dart';
import '../controllers/update_avatar_controller.dart';

class UpdateAvatarBinding implements Bindings {
  UpdateAvatarBinding({required AccountRepository accountRepository})
      : _accountRepository = accountRepository;

  final AccountRepository _accountRepository;

  @override
  void dependencies() {
    Get.lazyPut(
      () => UpdateAvatarController(
        repository: _accountRepository,
      ),
    );
  }
}
