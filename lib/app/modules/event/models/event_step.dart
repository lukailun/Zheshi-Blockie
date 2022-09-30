import 'package:blockie_app/extensions/extensions.dart';
import 'package:json_annotation/json_annotation.dart';

part 'event_step.g.dart';

@JsonSerializable(explicitToJson: true)
class EventStep {
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
  final int? eventStatusValue;

  EventStep({
    required this.statusValue,
    required this.title,
    required this.ID,
    this.time,
    this.description,
    this.imagePath,
    this.eventStatusValue,
  });

  EventStepStatus get status =>
      EventStepStatus.values.firstWhere((it) => it.value == statusValue);

  ProjectStatus get eventStatus => ProjectStatus.values
      .firstWhere((it) => it.value == (eventStatusValue ?? 0));

  String? get imageUrl => imagePath?.hostAdded;

  factory EventStep.fromJson(Map<String, dynamic> json) =>
      _$EventStepFromJson(json);

  Map<String, dynamic> toJson() => _$EventStepToJson(this);
}

enum EventStepStatus {
  toDo(0),
  done(1);

  const EventStepStatus(this.value);

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
