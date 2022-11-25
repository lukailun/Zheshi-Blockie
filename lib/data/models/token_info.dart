// Package imports:
import 'package:json_annotation/json_annotation.dart';

part 'token_info.g.dart';

@JsonSerializable(explicitToJson: true)
class TokenInfo {
  @JsonKey(name: 'token')
  final String token;

  TokenInfo({
    required this.token,
  });

  factory TokenInfo.fromJson(Map<String, dynamic> json) =>
      _$TokenInfoFromJson(json);

  Map<String, dynamic> toJson() => _$TokenInfoToJson(this);
}
