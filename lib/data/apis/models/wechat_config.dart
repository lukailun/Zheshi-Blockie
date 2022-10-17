// Package imports:
import 'package:json_annotation/json_annotation.dart';

part 'wechat_config.g.dart';

@JsonSerializable(
  createToJson: false,
  explicitToJson: true,
)
class WechatConfig {
  @JsonKey(name: 'appId')
  String appID;
  @JsonKey(name: 'nonceStr')
  String nonceString;
  @JsonKey(name: 'timestamp')
  int timestamp;
  @JsonKey(name: 'signature')
  String signature;
  @JsonKey(name: 'jsApiList')
  List<String> APIs;
  @JsonKey(name: 'debug')
  bool isDebug;

  WechatConfig({
    required this.appID,
    required this.nonceString,
    required this.timestamp,
    required this.signature,
    required this.APIs,
    required this.isDebug,
  });

  factory WechatConfig.fromJson(Map<String, dynamic> json) =>
      _$WechatConfigFromJson(json);
}
