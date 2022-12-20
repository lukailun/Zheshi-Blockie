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
      subactivities: (json['activities'] as List<dynamic>)
          .map((e) => Subactivity.fromJson(e as Map<String, dynamic>))
          .toList(),
      issuer: json['issuer'] == null
          ? null
          : Issuer.fromJson(json['issuer'] as Map<String, dynamic>),
      type: $enumDecode(_$ActivityTypeEnumMap, json['type']),
    );

Map<String, dynamic> _$ActivityToJson(Activity instance) => <String, dynamic>{
      'uid': instance.id,
      'name': instance.name,
      'summary': instance.summary,
      'description': instance.description,
      'activities': instance.subactivities.map((e) => e.toJson()).toList(),
      'issuer': instance.issuer?.toJson(),
      'type': _$ActivityTypeEnumMap[instance.type]!,
    };

const _$ActivityTypeEnumMap = {
  ActivityType.activity: 2,
  ActivityType.subactivity: 1,
};
