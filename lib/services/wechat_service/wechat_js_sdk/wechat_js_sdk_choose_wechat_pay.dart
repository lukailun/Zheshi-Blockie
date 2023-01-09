part of wechat_js_sdk;

@JS('wx.chooseWXPay')
external Object wechatChooseWechatPay(WechatChooseWechatPayParams params);

@JS()
@anonymous
class WechatChooseWechatPayParams {
  external int get timestamp;

  external String nonceStr;
  external String package;
  external String signType;
  external String paySign;

  external Function(WechatChooseWechatPayResult) get success;

  external factory WechatChooseWechatPayParams({
    int timestamp,
    String nonceStr,
    String package,
    String signType,
    String paySign,
    Function(WechatChooseWechatPayResult) success,
  });
}

@JS()
@anonymous
class WechatChooseWechatPayResult {
  external String get errMsg;

  external factory WechatChooseWechatPayResult({
    String errMsg,
  });
}
