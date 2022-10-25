// Package imports:
import 'package:json_annotation/json_annotation.dart';

// Project imports:
import 'package:blockie_app/app/modules/project_details/models/mint_geometry.dart';

part 'mint_rule_info.g.dart';

@JsonSerializable(explicitToJson: true)
class MintRuleInfo {
  @JsonKey(name: 'pos')
  final MintGeometry? geometry;
  @JsonKey(name: 'mint_code')
  final String? checkCode;

  const MintRuleInfo({
    required this.geometry,
    required this.checkCode,
  });

  factory MintRuleInfo.fromJson(Map<String, dynamic> json) =>
      _$MintRuleInfoFromJson(json);

  Map<String, dynamic> toJson() => _$MintRuleInfoToJson(this);
}
