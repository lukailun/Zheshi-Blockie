import 'package:blockie_app/app/modules/share/controllers/share_controller.dart';
import 'package:blockie_app/app/routes/app_pages.dart';
import 'package:blockie_app/data/repositories/project_repository.dart';
import 'package:get/get.dart';

part 'nft_details_controller_router.dart';

class NftDetailsController extends GetxController {
  NftDetailsController({
    required this.projectRepository,
  });

  final ProjectRepository projectRepository;
  final id = Get.parameters[NftDetailsParameter.id] as String;
}

class NftDetailsParameter {
  static const id = 'id';
}
