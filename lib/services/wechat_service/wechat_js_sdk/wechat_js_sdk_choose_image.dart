part of wechat_js_sdk;

@JS('wx.chooseImage')
external Object wechatChooseImage(WechatChooseImageParams params);

@JS()
@anonymous
class WechatChooseImageParams {
  external int get count;

  external List<String> get sizeType;

  external List<String> get sourceType;

  external Function(WechatChooseImageResult) get success;

  external factory WechatChooseImageParams({
    int count,
    List<String> sizeType,
    List<String> sourceType,
    Function(WechatChooseImageResult) success,
  });
}

@JS()
@anonymous
class WechatChooseImageResult {
  external String get errMsg;

  external List<String>? get localIds;

  external factory WechatChooseImageResult({
    String errMsg,
    List<String>? localIds,
  });
}
