part of 'nft_details_controller.dart';

extension NftDetailsControllerRouter on NftDetailsController {
  void goToShare() async {
    final parameters = {ShareParameter.id: id, ShareParameter.isNft: 'true'};
    await AppRouter.toNamed(Routes.share, parameters: parameters);
    isDefaultConfig = false;
  }

  void goToBrandDetails(String id) async {
    final parameters = {BrandDetailsParameter.id: id};
    await AppRouter.toNamed(Routes.brand, parameters: parameters);
    isDefaultConfig = false;
  }

  void goToProfile() async {
    await Get.offNamed(Routes.profile);
    isDefaultConfig = false;
  }

  void goToActivities() async {
    await Get.offAllNamed(Routes.activities);
    isDefaultConfig = false;
  }
}
