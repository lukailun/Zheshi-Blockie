// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paginated_activities.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaginatedActivities _$PaginatedActivitiesFromJson(Map<String, dynamic> json) =>
    PaginatedActivities(
      nextPageUrl: json['next_page_url'] as String?,
      activities: (json['data'] as List<dynamic>)
          .map((e) => Activity.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PaginatedActivitiesToJson(
        PaginatedActivities instance) =>
    <String, dynamic>{
      'next_page_url': instance.nextPageUrl,
      'data': instance.activities.map((e) => e.toJson()).toList(),
    };
