part of wechat_js_sdk;

@JS('wx.scanQRCode')
external Object wechatScanQrCode(WechatScanQrCodeParams params);

@JS()
@anonymous
class WechatScanQrCodeParams {
  external int get needResult;

  external String get scanType;

  external Function(Map<String, dynamic>) get success;

  external factory WechatScanQrCodeParams({
    int needResult,
    String scanType,
    Function(Map<String, dynamic>) success,
  });
}
