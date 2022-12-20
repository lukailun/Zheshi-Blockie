// Package imports:
import 'package:blockie_app/app/routes/app_router.dart';
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/app/modules/nft_details/controllers/nft_details_controller.dart';
import 'package:blockie_app/app/modules/profile/models/profile.dart';
import 'package:blockie_app/app/modules/profile/models/profile_label.dart';
import 'package:blockie_app/app/modules/profile/views/qr_code_dialog.dart';
import 'package:blockie_app/app/modules/profile/views/update_labels_dialog.dart';
import 'package:blockie_app/app/routes/app_pages.dart';
import 'package:blockie_app/data/repositories/account_repository.dart';
import 'package:blockie_app/data/repositories/profile_repository.dart';
import 'package:blockie_app/services/auth_service.dart';
import 'package:blockie_app/utils/data_storage.dart';

part 'profile_controller_router.dart';

class ProfileController extends GetxController {
  final AccountRepository accountRepository;
  final ProfileRepository profileRepository;

  ProfileController({
    required this.accountRepository,
    required this.profileRepository,
  });

  final qrCode = Rxn<String>();
  final profile = Rxn<Profile>();
  final labels = Rxn<List<ProfileLabel>>();
  final isTagsExpanded = false.obs;
  final userInfo = AuthService.to.userInfo;

  @override
  void onReady() {
    super.onReady();
    getUserInfo();
  }

  void toggleTags() {
    isTagsExpanded.value = !isTagsExpanded.value;
  }

  void getUserInfo() async {
    if ((DataStorage.getToken() ?? '').isNotEmpty) {
      final user = await accountRepository.getUserInfo();
      AuthService.to.userInfo.value = user;
      AuthService.to.login();
      getQrCode();
      getProfile();
    } else {
      AuthService.to.userInfo.value = null;
      AuthService.to.logout();
    }
  }

  void getQrCode() async {
    qrCode.value = await accountRepository.getQrCode();
  }

  void getProfile() async {
    profile.value = await profileRepository.getProfile();
  }

  void updateLabels(List<String> ids) async {
    await profileRepository.updateLabels(ids);
    getProfile();
  }
}

class ProfileParameter {
  static const id = 'id';
}
