// Package imports:
import 'package:json_annotation/json_annotation.dart';

part 'wechat_config.g.dart';

@JsonSerializable(explicitToJson: true)
class WechatConfig {
  @JsonKey(name: 'appId')
  String appId;
  @JsonKey(name: 'nonceStr')
  String nonceString;
  @JsonKey(name: 'timestamp')
  int timestamp;
  @JsonKey(name: 'signature')
  String signature;
  @JsonKey(name: 'jsApiList')
  List<String> apis;
  @JsonKey(name: 'openTagList')
  List<String> openTags;
  @JsonKey(name: 'debug')
  bool isDebug;

  WechatConfig({
    required this.appId,
    required this.nonceString,
    required this.timestamp,
    required this.signature,
    required this.apis,
    required this.openTags,
    required this.isDebug,
  });

  factory WechatConfig.fromJson(Map<String, dynamic> json) =>
      _$WechatConfigFromJson(json);

  Map<String, dynamic> toJson() => _$WechatConfigToJson(this);
}
