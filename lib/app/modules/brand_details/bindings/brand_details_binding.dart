// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/app/modules/brand_details/controllers/brand_details_controller.dart';
import 'package:blockie_app/data/repositories/project_repository.dart';

class BrandDetailsBinding implements Bindings {
  final ProjectRepository projectRepository;

  BrandDetailsBinding({
    required this.projectRepository,
  });

  @override
  void dependencies() {
    Get.lazyPut(
      () => BrandDetailsController(
        projectRepository: projectRepository,
      ),
    );
  }
}
