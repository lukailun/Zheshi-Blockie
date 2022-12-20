// Package imports:
import 'package:json_annotation/json_annotation.dart';

// Project imports:
import 'package:blockie_app/app/modules/activity/models/subactivity_preview.dart';
import 'package:blockie_app/data/models/issuer.dart';
import 'package:blockie_app/extensions/extensions.dart';

part 'activity.g.dart';

@JsonSerializable(explicitToJson: true)
class Activity {
  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'uid')
  final String id;
  @JsonKey(name: 'activities')
  final List<SubactivityPreview> subactivityPreviews;
  @JsonKey(name: 'issuer')
  final Issuer issuer;
  @JsonKey(name: 'cover_path')
  final String coverPath;
  @JsonKey(name: 'summary')
  final String summary;

  Activity({
    required this.name,
    required this.id,
    required this.subactivityPreviews,
    required this.issuer,
    required this.coverPath,
    required this.summary,
  });

  String? get coverUrl => coverPath.isNotEmpty ? coverPath.hostAdded : null;

  factory Activity.fromJson(Map<String, dynamic> json) =>
      _$ActivityFromJson(json);

  Map<String, dynamic> toJson() => _$ActivityToJson(this);
}
