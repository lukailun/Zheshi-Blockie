// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Activity _$ActivityFromJson(Map<String, dynamic> json) => Activity(
      name: json['name'] as String,
      summary: json['summary'] as String,
      description: json['description'] as String,
      id: json['uid'] as String,
      steps: (json['poster_components'] as List<dynamic>)
          .map((e) => ActivityStep.fromJson(e as Map<String, dynamic>))
          .toList(),
      issuer: Issuer.fromJson(json['issuer'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ActivityToJson(Activity instance) => <String, dynamic>{
      'name': instance.name,
      'summary': instance.summary,
      'description': instance.description,
      'uid': instance.id,
      'poster_components': instance.steps.map((e) => e.toJson()).toList(),
      'issuer': instance.issuer.toJson(),
    };
