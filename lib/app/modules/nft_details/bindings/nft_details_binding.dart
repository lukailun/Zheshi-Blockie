import 'package:blockie_app/data/repositories/project_repository.dart';
import 'package:get/get.dart';
import 'package:blockie_app/app/modules/nft_details/controllers/nft_details_controller.dart';

class NftDetailsBinding implements Bindings {
  NftDetailsBinding({
    required this.projectRepository,
  });

  final ProjectRepository projectRepository;

  @override
  void dependencies() {
    Get.lazyPut(
        () => NftDetailsController(projectRepository: projectRepository));
  }
}
