// Package imports:
import 'package:blockie_app/data/repositories/account_repository.dart';
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/app/modules/activity/controllers/activity_controller.dart';
import 'package:blockie_app/data/repositories/project_repository.dart';

class ActivityBinding implements Bindings {
  ActivityBinding({
    required this.accountRepository,
    required this.projectRepository,
  });

  final AccountRepository accountRepository;
  final ProjectRepository projectRepository;

  @override
  void dependencies() {
    Get.lazyPut(
      () => ActivityController(
        accountRepository: accountRepository,
        projectRepository: projectRepository,
      ),
    );
  }
}
