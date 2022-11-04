// Flutter imports:
import 'package:flutter/services.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/app/modules/profile/models/profile.dart';
import 'package:blockie_app/app/modules/profile/models/profile_label.dart';
import 'package:blockie_app/app/modules/profile/views/qr_code_dialog.dart';
import 'package:blockie_app/app/modules/profile/views/update_labels_dialog.dart';
import 'package:blockie_app/app/routes/app_pages.dart';
import 'package:blockie_app/data/repositories/account_repository.dart';
import 'package:blockie_app/data/repositories/profile_repository.dart';
import 'package:blockie_app/models/user_info.dart';
import 'package:blockie_app/services/auth_service.dart';
import 'package:blockie_app/utils/data_storage.dart';
import 'package:blockie_app/utils/http_request.dart';
import 'package:blockie_app/widgets/message_toast.dart';

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
  final user = AuthService.to.user;

  @override
  void onReady() {
    super.onReady();
    _updateUser();
  }

  void _updateUser() async {
    if ((DataStorage.getToken() ?? "").isNotEmpty) {
      UserInfo res = await HttpRequest.getUserInfo(DataStorage.getToken()!);
      AuthService.to.user.value = res;
      AuthService.to.login();
      _getQrCode();
      _getProfile();
    } else {
      AuthService.to.user.value = null;
      AuthService.to.logout();
    }
  }

  void _getQrCode() async {
    qrCode.value = await accountRepository.getQrCode();
  }

  void _getProfile() async {
    profile.value = await profileRepository.getProfile();
  }

  void goToProjects() {
    Get.offAllNamed(Routes.activities);
  }

  void goToSettings() {
    Get.toNamed(Routes.settings);
  }

  void goToUpdateUsername() {
    Get.toNamed(Routes.updateUsername);
  }

  void goToUpdateAvatar() {
    Get.toNamed(Routes.updateAvatar);
  }

  void goToUpdateBio() {
    Get.toNamed(Routes.updateBio);
  }

  void goToNftDetails(String id) {
    final parameters = {
      'uid': id,
    };
    Get.toNamed(Routes.nft, parameters: parameters);
  }

  void copyWalletAddress(String walletAddress) {
    Clipboard.setData(ClipboardData(text: walletAddress));
    MessageToast.showMessage("复制成功");
  }

  void openQrCodeDialog() {
    final userValue = user.value;
    final qrCodeValue = qrCode.value;
    if (userValue == null || qrCodeValue == null) {
      return;
    }
    Get.qrCodeDialog(
      user: userValue,
      qrCode: qrCodeValue,
    );
  }

  void openUpdateLabelsDialog(int index) async {
    labels.value ??= await profileRepository.getAllLabels();
    if ((labels.value ?? []).isNotEmpty) {
      final selectedLabelIds =
          profile.value?.labels.map((it) => it.id).toList() ?? [];
      Get.updateLabelsDialog(
          labels: labels.value ?? [],
          labelOnTap: (id) {
            Get.back();
            List<String> ids = selectedLabelIds;
            if (index >= selectedLabelIds.length) {
              ids += [id];
            } else {
              final currentIndex = ids.indexOf(id);
              if (currentIndex == -1) {
                ids[index] = id;
              } else {
                if (currentIndex == index) {
                  return;
                }
                ids[currentIndex] = ids[index];
                ids[index] = id;
              }
            }
            updateLabels(ids);
          });
    }
  }

  void updateLabels(List<String> ids) async {
    await profileRepository.updateLabels(ids);
    _getProfile();
  }
}

class ProfileParameter {
  static const id = 'id';
}
