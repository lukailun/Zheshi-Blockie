// Package imports:
import 'package:json_annotation/json_annotation.dart';

// Project imports:
import 'package:blockie_app/app/modules/project_details/models/mint_rule_info.dart';

part 'project_details_extra_info.g.dart';

@JsonSerializable(explicitToJson: true)
class ProjectDetailsExtraInfo {
  @JsonKey(name: 'rules')
  final MintRuleInfo? ruleInfo;

  const ProjectDetailsExtraInfo({
    required this.ruleInfo,
  });

  factory ProjectDetailsExtraInfo.fromJson(Map<String, dynamic> json) =>
      _$ProjectDetailsExtraInfoFromJson(json);

  Map<String, dynamic> toJson() => _$ProjectDetailsExtraInfoToJson(this);
}
