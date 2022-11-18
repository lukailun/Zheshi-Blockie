// Package imports:
import 'package:blockie_app/app/modules/activity/models/subactivity_step_type.dart';
import 'package:json_annotation/json_annotation.dart';

// Project imports:
import 'package:blockie_app/extensions/extensions.dart';

part 'subactivity_step.g.dart';

@JsonSerializable(explicitToJson: true)
class SubactivityStep {
  @JsonKey(name: 'action')
  final String id;
  @JsonKey(name: 'category_cn')
  final String category;
  @JsonKey(name: 'name')
  final String title;
  @JsonKey(name: 'icon_path')
  final String iconPath;
  @JsonKey(name: 'status')
  final bool isCompleted;

  SubactivityStep({
    required this.id,
    required this.category,
    required this.title,
    required this.iconPath,
    required this.isCompleted,
  });

  String? get iconUrl => iconPath.isNotEmpty ? iconPath.hostAdded : null;

  SubactivityStepType get type =>
      SubactivityStepType.values.firstWhere((it) => it.value == id);

  factory SubactivityStep.fromJson(Map<String, dynamic> json) =>
      _$SubactivityStepFromJson(json);

  Map<String, dynamic> toJson() => _$SubactivityStepToJson(this);
}
