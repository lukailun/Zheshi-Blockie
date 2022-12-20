// Package imports:
import 'package:json_annotation/json_annotation.dart';

// Project imports:
import 'package:blockie_app/app/modules/activities_management/models/activity.dart';

part 'paginated_managed_activities.g.dart';

@JsonSerializable(explicitToJson: true)
class PaginatedManagedActivities {
  @JsonKey(name: 'next_page_url')
  String? nextPageUrl;
  @JsonKey(name: 'data')
  List<Activity> activities;

  PaginatedManagedActivities({
    required this.nextPageUrl,
    required this.activities,
  });

  factory PaginatedManagedActivities.fromJson(Map<String, dynamic> json) =>
      _$PaginatedManagedActivitiesFromJson(json);

  Map<String, dynamic> toJson() => _$PaginatedManagedActivitiesToJson(this);
}
