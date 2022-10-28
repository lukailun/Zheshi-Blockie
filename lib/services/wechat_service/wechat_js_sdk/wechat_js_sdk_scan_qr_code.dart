part of wechat_js_sdk;

@JS('wx.scanQRCode')
external Object wechatScanQrCode(WechatScanQrCodeParams params);

@JS()
@anonymous
class WechatScanQrCodeParams {
  external int get needResult;

  external String get scanType;

  external Function(WechatScanQrCodeResult) get success;

  external factory WechatScanQrCodeParams({
    int needResult,
    String scanType,
    Function(WechatScanQrCodeResult) success,
  });
}

@JS()
@anonymous
class WechatScanQrCodeResult {
  external String get resultStr;

  external String get errMsg;

  external factory WechatScanQrCodeResult({
    String resultStr,
    String errMsg,
  });
}
