// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/app/modules/airdrop_nft/controllers/airdrop_nft_controller.dart';
import 'package:blockie_app/data/repositories/project_management_repository.dart';

class AirdropNftBinding implements Bindings {
  final ProjectManagementRepository projectManagementRepository;

  AirdropNftBinding({required this.projectManagementRepository});

  @override
  void dependencies() {
    Get.lazyPut(
        () => AirdropNftController(repository: projectManagementRepository));
  }
}
