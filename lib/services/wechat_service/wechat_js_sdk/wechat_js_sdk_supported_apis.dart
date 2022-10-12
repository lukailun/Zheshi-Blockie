part of wechat_js_sdk;

enum WechatSupportedAPIs {
  updateAppMessageShareData("updateAppMessageShareData"),
  updateTimelineShareData("updateTimelineShareData");

  const WechatSupportedAPIs(this.value);

  final String value;
}

final wechatSupportedAPIs =
WechatSupportedAPIs.values.map((it) => it.value).toList();
