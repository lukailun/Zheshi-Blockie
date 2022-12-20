// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Project _$ProjectFromJson(Map<String, dynamic> json) => Project(
      id: json['uid'] as String,
      title: json['name'] as String,
      coverPath: json['cover_path'] as String,
    );

Map<String, dynamic> _$ProjectToJson(Project instance) => <String, dynamic>{
      'uid': instance.id,
      'name': instance.title,
      'cover_path': instance.coverPath,
    };
