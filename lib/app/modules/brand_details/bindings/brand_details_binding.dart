import 'package:blockie_app/data/repositories/project_repository.dart';
import 'package:get/get.dart';
import 'package:blockie_app/app/modules/brand_details/controllers/brand_details_controller.dart';

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
