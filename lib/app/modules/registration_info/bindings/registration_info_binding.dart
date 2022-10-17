// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/data/repositories/account_repository.dart';
import 'package:blockie_app/data/repositories/project_repository.dart';
import 'package:blockie_app/utils/http_request.dart';
import '../../../../data/apis/blockie_api.dart';
import '../../../../utils/data_storage.dart';
import '../controllers/registration_info_controller.dart';

class RegistrationInfoBinding implements Bindings {
  RegistrationInfoBinding({required AccountRepository accountRepository})
      : _accountRepository = accountRepository;

  final AccountRepository _accountRepository;

  @override
  void dependencies() {
    Get.lazyPut(
      () => RegistrationInfoController(
        accountRepository: _accountRepository,
        projectRepository: ProjectRepository(client: HttpRequest()),
      ),
    );
  }
}
