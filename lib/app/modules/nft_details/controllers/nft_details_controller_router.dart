part of 'nft_details_controller.dart';

extension NftDetailsControllerRouter on NftDetailsController {
  void goToShare() async {
    final parameters = {
      ShareParameter.id: '',
      ShareParameter.isNft: 'true',
    };
    await Get.toNamed(Routes.share, parameters: parameters);
    // isDefaultConfig = false;
    // _goneToShare = false;
  }
}
