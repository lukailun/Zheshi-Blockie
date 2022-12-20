// Package imports:
import 'package:json_annotation/json_annotation.dart';

part 'wechat_mini_program_code.g.dart';

@JsonSerializable(explicitToJson: true)
class WechatMiniProgramCode {
  @JsonKey(name: 'code')
  String base64String;

  WechatMiniProgramCode({
    required this.base64String,
  });

  factory WechatMiniProgramCode.fromJson(Map<String, dynamic> json) =>
      _$WechatMiniProgramCodeFromJson(json);

  Map<String, dynamic> toJson() => _$WechatMiniProgramCodeToJson(this);
}
