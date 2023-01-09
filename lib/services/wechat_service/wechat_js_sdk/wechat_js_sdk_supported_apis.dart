part of wechat_js_sdk;

enum WechatSupportedApis {
  updateAppMessageShareData('updateAppMessageShareData'),
  updateTimelineShareData('updateTimelineShareData'),
  scanQrCode('scanQRCode'),
  getLocation('getLocation'),
  chooseImage('chooseImage'),
  getLocalImageData('getLocalImgData'),
  openLocation('openLocation'),
  chooseWechatPay('chooseWXPay');

  const WechatSupportedApis(this.value);

  final String value;
}

final wechatSupportedApis =
    WechatSupportedApis.values.map((it) => it.value).toList();
