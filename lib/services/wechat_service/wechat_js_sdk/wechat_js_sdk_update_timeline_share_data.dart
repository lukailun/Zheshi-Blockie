part of wechat_js_sdk;

@JS('wx.updateTimelineShareData')
external Object wechatUpdateTimelineShareData(
    WechatUpdateTimelineShareDataParams params);

@JS()
@anonymous
class WechatUpdateTimelineShareDataParams {
  external String get title;

  external String get link;

  external String get imgUrl;

  external Function() get success;

  external factory WechatUpdateTimelineShareDataParams({
    String title,
    String link,
    String imgUrl,
    Function() success,
  });
}
