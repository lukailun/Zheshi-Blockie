// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paginated_managed_activities.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaginatedManagedActivities _$PaginatedManagedActivitiesFromJson(
        Map<String, dynamic> json) =>
    PaginatedManagedActivities(
      nextPageUrl: json['next_page_url'] as String?,
      activities: (json['data'] as List<dynamic>)
          .map((e) => Activity.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PaginatedManagedActivitiesToJson(
        PaginatedManagedActivities instance) =>
    <String, dynamic>{
      'next_page_url': instance.nextPageUrl,
      'data': instance.activities.map((e) => e.toJson()).toList(),
    };
