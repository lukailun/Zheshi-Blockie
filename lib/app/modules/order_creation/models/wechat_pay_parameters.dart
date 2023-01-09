// Package imports:
import 'package:json_annotation/json_annotation.dart';

part 'wechat_pay_parameters.g.dart';

@JsonSerializable(explicitToJson: true)
class WechatPayParameters {
  @JsonKey(name: 'timeStamp')
  int timestamp;
  @JsonKey(name: 'nonceStr')
  String nonceString;
  @JsonKey(name: 'package')
  String package;
  @JsonKey(name: 'signType')
  String signType;
  @JsonKey(name: 'paySign')
  String paySign;

  WechatPayParameters({
    required this.timestamp,
    required this.nonceString,
    required this.package,
    required this.signType,
    required this.paySign,
  });

  factory WechatPayParameters.fromJson(Map<String, dynamic> json) =>
      _$WechatPayParametersFromJson(json);

  Map<String, dynamic> toJson() => _$WechatPayParametersToJson(this);
}
