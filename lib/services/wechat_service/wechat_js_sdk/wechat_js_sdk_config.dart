part of wechat_js_sdk;

@JS('wx.config')
external Object wechatConfig(WechatConfigParams params);

@JS()
@anonymous
class WechatConfigParams {
  external bool get debug;

  external String get appId;

  external int get timestamp;

  external String get nonceStr;

  external String get signature;

  external List<String> get jsApiList;

  external List<String> get openTagList;

  external factory WechatConfigParams({
    bool debug,
    String appId,
    int timestamp,
    String nonceStr,
    String signature,
    List<String> jsApiList,
    List<String> openTagList,
  });
}
