// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paginated_projects.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaginatedProjects _$PaginatedProjectsFromJson(Map<String, dynamic> json) =>
    PaginatedProjects(
      nextPageUrl: json['next_page_url'] as String?,
      projectsList: (json['data'] as List<dynamic>)
          .map((e) => Projects.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PaginatedProjectsToJson(PaginatedProjects instance) =>
    <String, dynamic>{
      'next_page_url': instance.nextPageUrl,
      'data': instance.projectsList.map((e) => e.toJson()).toList(),
    };
