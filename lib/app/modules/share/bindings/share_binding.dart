// Package imports:
import 'package:blockie_app/data/repositories/common_repository.dart';
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/app/modules/share/controllers/share_controller.dart';
import 'package:blockie_app/data/repositories/project_repository.dart';

class ShareBinding implements Bindings {
  ShareBinding({
    required this.projectRepository,
    required this.commonRepository,
  });

  final ProjectRepository projectRepository;
  final CommonRepository commonRepository;

  @override
  void dependencies() {
    Get.lazyPut(
      () => ShareController(
        projectRepository: projectRepository,
        commonRepository: commonRepository,
      ),
    );
  }
}
