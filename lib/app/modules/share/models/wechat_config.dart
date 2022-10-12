import 'package:json_annotation/json_annotation.dart';

part 'wechat_config.g.dart';

@JsonSerializable(explicitToJson: true)
class WechatConfig {
  @JsonKey(name: 'appId')
  String appID;
  @JsonKey(name: 'nonceStr')
  String nonce;
  int timestamp;
  String signature;
  @JsonKey(name: 'jsApiList')
  List<String> APIs;
  @JsonKey(name: 'debug')
  bool isDebug;


  WechatConfig({
    required this.appID,
    required this.nonce,
    required this.timestamp,
    required this.signature,
    required this.APIs,
    required this.isDebug,
  });

  factory WechatConfig.fromJson(Map<String, dynamic> json) =>
      _$WechatConfigFromJson(json);

  Map<String, dynamic> toJson() => _$WechatConfigToJson(this);
}
