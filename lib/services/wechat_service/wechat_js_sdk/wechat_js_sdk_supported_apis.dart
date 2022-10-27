part of wechat_js_sdk;

enum WechatSupportedApis {
  updateAppMessageShareData("updateAppMessageShareData"),
  updateTimelineShareData("updateTimelineShareData");

  const WechatSupportedApis(this.value);

  final String value;
}

final wechatSupportedApis =
    WechatSupportedApis.values.map((it) => it.value).toList();
