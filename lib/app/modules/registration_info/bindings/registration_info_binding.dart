// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/data/repositories/account_repository.dart';
import 'package:blockie_app/data/repositories/project_repository.dart';
import '../controllers/registration_info_controller.dart';

class RegistrationInfoBinding implements Bindings {
  RegistrationInfoBinding({
    required AccountRepository accountRepository,
    required ProjectRepository projectRepository,
  })  : _accountRepository = accountRepository,
        _projectRepository = projectRepository;

  final AccountRepository _accountRepository;
  final ProjectRepository _projectRepository;

  @override
  void dependencies() {
    Get.lazyPut(
      () => RegistrationInfoController(
        accountRepository: _accountRepository,
        projectRepository: _projectRepository,
      ),
    );
  }
}
