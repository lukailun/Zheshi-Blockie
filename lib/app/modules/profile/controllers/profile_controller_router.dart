part of 'profile_controller.dart';

extension ProfileControllerRouter on ProfileController {
  void goToEditUserInfo() {
    AppRouter.toNamed(Routes.editUserInfo);
  }

  void goToProjects() {
    Get.offAllNamed(Routes.activities);
  }

  void goToSettings() {
    AppRouter.toNamed(Routes.settings);
  }

  void goToOrders() {
    AppRouter.toNamed(Routes.orderCreation);
  }

  void goToNftDetails(String id) {
    final parameters = {NftDetailsParameter.id: id};
    AppRouter.toNamed(Routes.nftDetails, parameters: parameters);
  }

  void openQrCodeDialog() {
    final userInfoValue = userInfo.value;
    final qrCodeValue = qrCode.value;
    if (userInfoValue == null || qrCodeValue == null) {
      return;
    }
    Get.qrCodeDialog(
      user: userInfoValue,
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
}
