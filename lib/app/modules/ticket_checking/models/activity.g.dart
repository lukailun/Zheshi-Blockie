// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Activity _$ActivityFromJson(Map<String, dynamic> json) => Activity(
      id: json['uid'] as String,
      name: json['name'] as String,
      coverPath: json['cover'] as String,
    );

Map<String, dynamic> _$ActivityToJson(Activity instance) => <String, dynamic>{
      'uid': instance.id,
      'name': instance.name,
      'cover': instance.coverPath,
    };
