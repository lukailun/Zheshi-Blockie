// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/app/modules/share/controllers/share_controller.dart';
import 'package:blockie_app/data/repositories/project_repository.dart';

class ShareBinding implements Bindings {
  ShareBinding({required ProjectRepository projectRepository})
      : _projectRepository = projectRepository;

  final ProjectRepository _projectRepository;

  @override
  void dependencies() {
    Get.lazyPut(
          () => ShareController(repository: _projectRepository),
    );
  }
}
