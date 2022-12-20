// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/app/modules/activity/controllers/subactivity_controller.dart';
import 'package:blockie_app/app/modules/activity/models/subactivity_preview.dart';
import 'package:blockie_app/app/modules/activity/views/subactivity_view.dart';
import 'package:blockie_app/data/repositories/account_repository.dart';
import 'package:blockie_app/data/repositories/project_repository.dart';

class SubactivityBinding implements Bindings {
  final AccountRepository accountRepository;
  final ProjectRepository projectRepository;
  final SubactivityPreview preview;

  SubactivityBinding({
    required this.accountRepository,
    required this.projectRepository,
    required this.preview,
  });

  @override
  void dependencies() {
    Get.lazyPut(
      () => SubactivityController(
        accountRepository: accountRepository,
        projectRepository: projectRepository,
        preview: preview,
      ),
      tag: preview.id,
    );
    Get.lazyPut(
      () => SubactivityView(id: preview.id),
      tag: preview.id,
    );
  }
}
