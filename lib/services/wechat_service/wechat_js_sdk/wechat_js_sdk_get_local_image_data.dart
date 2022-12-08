part of wechat_js_sdk;

@JS('wx.getLocalImgData')
external Object wechatGetLocalImageData(WechatGetLocalImageDataParams params);

@JS()
@anonymous
class WechatGetLocalImageDataParams {
  external String get localId;

  external Function(WechatGetLocalImageDataResult) get success;

  external factory WechatGetLocalImageDataParams({
    String localId,
    Function(WechatGetLocalImageDataResult) success,
  });
}

@JS()
@anonymous
class WechatGetLocalImageDataResult {
  external String? get localData;

  external factory WechatGetLocalImageDataResult({
    String? localData,
  });
}
