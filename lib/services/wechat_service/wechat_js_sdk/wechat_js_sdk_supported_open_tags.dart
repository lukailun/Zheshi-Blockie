part of wechat_js_sdk;

enum WechatSupportedOpenTags {
  launchMiniProgram('wx-open-launch-weapp');

  const WechatSupportedOpenTags(this.value);

  final String value;
}

final wechatSupportedOpenTags =
    WechatSupportedOpenTags.values.map((it) => it.value).toList();
