// Flutter imports:
import 'package:blockie_app/app/modules/profile/models/profile.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/app/modules/profile/views/qr_code_dialog.dart';
import 'package:blockie_app/app/routes/app_pages.dart';
import 'package:blockie_app/data/repositories/account_repository.dart';
import 'package:blockie_app/models/user_info.dart';
import 'package:blockie_app/services/auth_service.dart';
import 'package:blockie_app/utils/data_storage.dart';
import 'package:blockie_app/utils/http_request.dart';
import 'package:blockie_app/widgets/message_toast.dart';

class ProfileController extends GetxController {
  final AccountRepository repository;

  ProfileController({required this.repository});

  final qrCode = Rxn<String>();
  final profile = Rxn<Profile>();
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
    qrCode.value = await repository.getQrCode();
  }

  void _getProfile() async {
    profile.value = await repository.getProfile();
  }

  void goToProjects() {
    Get.offAllNamed(Routes.initial);
  }

  void goToSettings() {
    Get.toNamed(Routes.settings);
  }

  void goToUpdateName() {
    Get.toNamed(Routes.updateName);
  }

  void goToUpdateAvatar() {
    Get.toNamed(Routes.updateAvatar);
  }

  void goToUpdateBio() {}

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
}

class ProfileParameter {
  static const id = "id";
}
