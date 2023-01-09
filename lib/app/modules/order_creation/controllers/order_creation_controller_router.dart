part of 'order_creation_controller.dart';

extension OrderCreationControllerRouter on OrderCreationController {
  void showCantPayDialog() {
    Get.twoButtonDialog(
      title: '提示',
      message: '您当前不在微信中，请前往微信公众号 BLOCKIE 购买',
      positiveButtonTitle: '确认',
      positiveButtonOnTap: () {
        Get.back();
        Get.back();
        AnchorUtils.openWechat();
      },
      negativeButtonTitle: '取消',
      negativeButtonOnTap: () {
        Get.back();
        Get.back();
      },
    );
  }
}
