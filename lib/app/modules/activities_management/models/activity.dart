// Package imports:
import 'package:json_annotation/json_annotation.dart';

// Project imports:
import 'package:blockie_app/app/modules/activities_management/models/activity_type.dart';
import 'package:blockie_app/app/modules/activities_management/models/subactivity.dart';
import 'package:blockie_app/data/models/issuer.dart';

part 'activity.g.dart';

@JsonSerializable(explicitToJson: true)
class Activity {
  @JsonKey(name: 'uid')
  String id;
  @JsonKey(name: 'name')
  String name;
  @JsonKey(name: 'summary')
  String? summary;
  @JsonKey(name: 'description')
  String? description;
  @JsonKey(name: 'activities')
  List<Subactivity> subactivities;
  @JsonKey(name: 'issuer')
  Issuer? issuer;
  @JsonKey(name: 'type')
  ActivityType type;

  Activity({
    required this.id,
    required this.name,
    required this.summary,
    required this.description,
    required this.subactivities,
    required this.issuer,
    required this.type,
  });

  factory Activity.fromJson(Map<String, dynamic> json) =>
      _$ActivityFromJson(json);

  Map<String, dynamic> toJson() => _$ActivityToJson(this);
}
