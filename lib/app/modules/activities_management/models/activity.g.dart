// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Activity _$ActivityFromJson(Map<String, dynamic> json) => Activity(
      id: json['uid'] as String,
      name: json['name'] as String,
      summary: json['summary'] as String?,
      description: json['description'] as String?,
      projects: (json['activities'] as List<dynamic>)
          .map((e) => Project.fromJson(e as Map<String, dynamic>))
          .toList(),
      issuer: json['issuer'] == null
          ? null
          : Issuer.fromJson(json['issuer'] as Map<String, dynamic>),
      typeValue: json['type'] as int,
    );

Map<String, dynamic> _$ActivityToJson(Activity instance) => <String, dynamic>{
      'uid': instance.id,
      'name': instance.name,
      'summary': instance.summary,
      'description': instance.description,
      'activities': instance.projects.map((e) => e.toJson()).toList(),
      'issuer': instance.issuer?.toJson(),
      'type': instance.typeValue,
    };
