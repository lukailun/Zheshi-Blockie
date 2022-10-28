part of wechat_js_sdk;

@JS('wx.checkJsApi')
external Object wechatCheckJSAPI(WechatCheckJSAPIParams params);

@JS()
@anonymous
class WechatCheckJSAPIParams {
  external List<String> get jsApiList;

  external Function(Map<String, dynamic>) get success;

  external factory WechatCheckJSAPIParams({
    List<String> jsApiList,
    Function(Map<String, dynamic>) success,
  });
}
