// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Activity _$ActivityFromJson(Map<String, dynamic> json) => Activity(
      name: json['name'] as String,
      id: json['uid'] as String,
      subactivityPreviews: (json['activities'] as List<dynamic>)
          .map((e) => SubactivityPreview.fromJson(e as Map<String, dynamic>))
          .toList(),
      issuer: Issuer.fromJson(json['issuer'] as Map<String, dynamic>),
      coverPath: json['cover_path'] as String,
      summary: json['summary'] as String,
    );

Map<String, dynamic> _$ActivityToJson(Activity instance) => <String, dynamic>{
      'name': instance.name,
      'uid': instance.id,
      'activities':
          instance.subactivityPreviews.map((e) => e.toJson()).toList(),
      'issuer': instance.issuer.toJson(),
      'cover_path': instance.coverPath,
      'summary': instance.summary,
    };
