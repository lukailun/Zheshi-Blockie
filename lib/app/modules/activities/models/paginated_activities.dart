// Package imports:
import 'package:json_annotation/json_annotation.dart';

// Project imports:
import 'package:blockie_app/app/modules/activities/models/activity.dart';

part 'paginated_activities.g.dart';

@JsonSerializable(explicitToJson: true)
class PaginatedActivities {
  @JsonKey(name: 'next_page_url')
  String? nextPageUrl;
  @JsonKey(name: 'data')
  List<Activity> activities;

  PaginatedActivities({
    required this.nextPageUrl,
    required this.activities,
  });

  factory PaginatedActivities.fromJson(Map<String, dynamic> json) =>
      _$PaginatedActivitiesFromJson(json);

  Map<String, dynamic> toJson() => _$PaginatedActivitiesToJson(this);
}
