// Package imports:
import 'package:json_annotation/json_annotation.dart';

// Project imports:
import 'package:blockie_app/app/modules/activity/models/activity_action_info.dart';
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
  final int? activityStatusValue;
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
    this.activityStatusValue,
  });

  ActivityStepStatus get status =>
      ActivityStepStatus.values.firstWhere((it) => it.value == statusValue);

  ProjectStatus get activityStatus => ProjectStatus.values
      .firstWhere((it) => it.value == (activityStatusValue ?? 0));

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

enum ProjectStatus {
  unknown(0, "未知"),
  notStarted(1, "活动未开始"),
  ongoing(2, "活动进行中"),
  expired(3, "活动已结束");

  const ProjectStatus(this.value, this.description);

  final int value;
  final String description;
}
