part of wechat_js_sdk;

@JS('wx.updateAppMessageShareData')
external Object wechatUpdateAppMessageShareData(
    WechatUpdateAppMessageShareDataParams params);

@JS()
@anonymous
class WechatUpdateAppMessageShareDataParams {
  external String get title;

  external String get desc;

  external String get link;

  external String get imgUrl;

  external Function() get success;

  external factory WechatUpdateAppMessageShareDataParams({
    String title,
    String desc,
    String link,
    String imgUrl,
    Function() success,
  });
}
