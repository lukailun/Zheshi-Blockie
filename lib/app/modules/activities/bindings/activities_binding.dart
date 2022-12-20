// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/app/modules/activities/controllers/activities_controller.dart';
import 'package:blockie_app/data/repositories/account_repository.dart';
import 'package:blockie_app/data/repositories/project_repository.dart';

class ActivitiesBinding implements Bindings {
  final AccountRepository accountRepository;
  final ProjectRepository projectRepository;

  ActivitiesBinding({
    required this.accountRepository,
    required this.projectRepository,
  });

  @override
  void dependencies() {
    Get.lazyPut(() => ActivitiesController(
          accountRepository: accountRepository,
          projectRepository: projectRepository,
        ));
  }
}
