// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/app/modules/activity/controllers/activity_controller.dart';
import 'package:blockie_app/data/repositories/project_repository.dart';

class ActivityBinding implements Bindings {
  ActivityBinding({
    required ProjectRepository projectRepository,
  }) : _projectRepository = projectRepository;
  final ProjectRepository _projectRepository;

  @override
  void dependencies() {
    Get.lazyPut(
      () => ActivityController(repository: _projectRepository),
    );
  }
}
