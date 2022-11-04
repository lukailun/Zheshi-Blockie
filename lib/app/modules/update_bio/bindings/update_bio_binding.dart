// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/app/modules/update_bio/controllers/update_bio_controller.dart';
import 'package:blockie_app/data/repositories/profile_repository.dart';

class UpdateBioBinding implements Bindings {
  UpdateBioBinding({
    required this.profileRepository,
  });

  final ProfileRepository profileRepository;

  @override
  void dependencies() {
    Get.lazyPut(
      () => UpdateBioController(
        repository: profileRepository,
      ),
    );
  }
}
