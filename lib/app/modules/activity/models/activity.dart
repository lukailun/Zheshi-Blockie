// Package imports:
import 'package:json_annotation/json_annotation.dart';

// Project imports:
import 'package:blockie_app/app/modules/activity/models/activity_step.dart';
import 'package:blockie_app/data/apis/models/issuer.dart';

part 'activity.g.dart';

@JsonSerializable(explicitToJson: true)
class Activity {
  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'summary')
  final String summary;
  @JsonKey(name: 'description')
  final String description;
  @JsonKey(name: 'uid')
  final String id;
  @JsonKey(name: 'poster_components')
  final List<ActivityStep> steps;
  @JsonKey(name: 'issuer')
  final Issuer issuer;

  Activity({
    required this.name,
    required this.summary,
    required this.description,
    required this.id,
    required this.steps,
    required this.issuer,
  });

  factory Activity.fromJson(Map<String, dynamic> json) =>
      _$ActivityFromJson(json);

  Map<String, dynamic> toJson() => _$ActivityToJson(this);
}
