part of wechat_js_sdk;

@JS('wx.getLocation')
external Object wechatGetLocation(WechatGetLocationParams params);

@JS()
@anonymous
class WechatGetLocationParams {
  external String get type;

  external Function(WechatGetLocationResult) get success;

  external factory WechatGetLocationParams({
    String type,
    Function(WechatGetLocationResult) success,
  });
}

@JS()
@anonymous
class WechatGetLocationResult {
  external String? get latitude;

  external String? get longitude;

  external String get errMsg;

  external factory WechatGetLocationResult({
    String latitude,
    String longitude,
    String errMsg,
  });
}
