import 'dart:html';

class AnchorUtils {
  static void call({
    required String phoneNumber,
  }) {
    AnchorElement(href: 'tel:$phoneNumber').click();
  }

  static void openWechat() {
    final anchorElement = AnchorElement(href: 'weixin://')..rel = 'nofollow';
    anchorElement.click();
  }

  static void openWechatMiniProgram({
    required String ticket,
  }) {
    final anchorElement = AnchorElement(href: 'weixin://dl/business/?t=$ticket')
      ..rel = 'nofollow';
    anchorElement.click();
  }

  static void download({
    required String url,
    required String fileName,
  }) {
    final anchorElement = AnchorElement(href: url)..download = fileName;
    anchorElement.click();
  }
}
