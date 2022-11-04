// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/app/modules/update_username/controllers/update_username_controller.dart';
import 'package:blockie_app/data/repositories/profile_repository.dart';

class UpdateUsernameBinding implements Bindings {
  UpdateUsernameBinding({
    required this.profileRepository,
  });

  final ProfileRepository profileRepository;

  @override
  void dependencies() {
    Get.lazyPut(
      () => UpdateUsernameController(
        repository: profileRepository,
      ),
    );
  }
}
