// Package imports:
import 'package:json_annotation/json_annotation.dart';

// Project imports:
import 'package:blockie_app/app/modules/activity/models/activity_action_info.dart';
import 'package:blockie_app/app/modules/project_details/models/project_status.dart';
import 'package:blockie_app/extensions/extensions.dart';

part 'activity_step.g.dart';

@JsonSerializable(explicitToJson: true)
class ActivityStep {
  @JsonKey(name: 'status')
  final int statusValue;
  @JsonKey(name: 'name')
  final String title;
  final String? description;
  final String? time;
  @JsonKey(name: 'image')
  final String? imagePath;
  @JsonKey(name: 'uid')
  final String ID;
  @JsonKey(name: 'activity_status')
  final int? projectStatusValue;
  @JsonKey(name: 'content')
  final ActivityActionInfo actionInfo;

  ActivityStep({
    required this.statusValue,
    required this.title,
    required this.ID,
    required this.actionInfo,
    this.time,
    this.description,
    this.imagePath,
    this.projectStatusValue,
  });

  ActivityStepStatus get status =>
      ActivityStepStatus.values.firstWhere((it) => it.value == statusValue);

  ProjectStatus get projectStatus => ProjectStatus.values
      .firstWhere((it) => it.value == (projectStatusValue ?? 0));

  String? get imageUrl => imagePath?.hostAdded;

  factory ActivityStep.fromJson(Map<String, dynamic> json) =>
      _$ActivityStepFromJson(json);

  Map<String, dynamic> toJson() => _$ActivityStepToJson(this);
}

enum ActivityStepStatus {
  toDo(0),
  done(1);

  const ActivityStepStatus(this.value);

  final int value;
}
