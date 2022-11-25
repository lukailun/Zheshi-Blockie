part of 'edit_user_info_controller.dart';

extension EditUserInfoControllerRouter on EditUserInfoController {
  void goToUpdateUsername() {
    Get.toNamed(Routes.updateUsername);
  }

  void goToUpdateAvatar() {
    Get.toNamed(Routes.updateAvatar);
  }

  void goToUpdateBio() {
    Get.toNamed(Routes.updateBio);
  }
}
