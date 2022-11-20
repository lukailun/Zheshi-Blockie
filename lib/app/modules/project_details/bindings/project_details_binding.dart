// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/app/modules/project_details/controllers/project_details_controller.dart';
import 'package:blockie_app/data/repositories/account_repository.dart';
import 'package:blockie_app/data/repositories/project_repository.dart';

class ProjectDetailsBinding implements Bindings {
  ProjectDetailsBinding({
    required this.accountRepository,
    required this.projectRepository,
  });

  final AccountRepository accountRepository;
  final ProjectRepository projectRepository;

  @override
  void dependencies() {
    Get.lazyPut(
      () => ProjectDetailsController(
        accountRepository: accountRepository,
        projectRepository: projectRepository,
      ),
    );
  }
}
