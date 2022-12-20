// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/app/modules/profile/controllers/profile_controller.dart';
import 'package:blockie_app/data/repositories/account_repository.dart';
import 'package:blockie_app/data/repositories/profile_repository.dart';

class ProfileBinding implements Bindings {
  ProfileBinding({
    required this.accountRepository,
    required this.profileRepository,
  });

  final AccountRepository accountRepository;
  final ProfileRepository profileRepository;

  @override
  void dependencies() {
    Get.lazyPut(
      () => ProfileController(
        accountRepository: accountRepository,
        profileRepository: profileRepository,
      ),
    );
  }
}
