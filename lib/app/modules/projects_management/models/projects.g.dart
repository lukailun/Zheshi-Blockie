// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'projects.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Projects _$ProjectsFromJson(Map<String, dynamic> json) => Projects(
      id: json['uid'] as String,
      name: json['name'] as String,
      summary: json['summary'] as String,
      description: json['description'] as String,
      typeValue: json['type'] as int,
      projects: (json['activities'] as List<dynamic>)
          .map((e) => Project.fromJson(e as Map<String, dynamic>))
          .toList(),
      issuer: Issuer.fromJson(json['issuer'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ProjectsToJson(Projects instance) => <String, dynamic>{
      'uid': instance.id,
      'name': instance.name,
      'summary': instance.summary,
      'description': instance.description,
      'type': instance.typeValue,
      'activities': instance.projects.map((e) => e.toJson()).toList(),
      'issuer': instance.issuer.toJson(),
    };
