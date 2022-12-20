part of 'edit_user_info_controller.dart';

extension EditUserInfoControllerRouter on EditUserInfoController {
  void goToUpdateUsername() {
    AppRouter.toNamed(Routes.updateUsername);
  }

  void goToUpdateAvatar() {
    AppRouter.toNamed(Routes.updateAvatar);
  }

  void goToUpdateBio() {
    AppRouter.toNamed(Routes.updateBio);
  }

  void goToUpdateGender() {
    AppRouter.toNamed(Routes.updateGender);
  }

  void goToUpdateBirthday() {
    AppRouter.toNamed(Routes.updateBirthday);
  }

  void goToUpdateRegion() {
    AppRouter.toNamed(Routes.updateRegion);
  }
}
