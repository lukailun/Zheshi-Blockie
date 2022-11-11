// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Activity _$ActivityFromJson(Map<String, dynamic> json) => Activity(
      id: json['uid'] as String,
      name: json['name'] as String,
      location: json['address'] as String,
      isOnline: json['is_online'] as bool,
      coverPath: json['cover_path'] as String,
      benefits:
          (json['rights'] as List<dynamic>).map((e) => e as String).toList(),
      issuer: Issuer.fromJson(json['issuer'] as Map<String, dynamic>),
      startedTimestamp: json['started_at'] as int,
    );

Map<String, dynamic> _$ActivityToJson(Activity instance) => <String, dynamic>{
      'uid': instance.id,
      'name': instance.name,
      'address': instance.location,
      'is_online': instance.isOnline,
      'cover_path': instance.coverPath,
      'rights': instance.benefits,
      'issuer': instance.issuer.toJson(),
      'started_at': instance.startedTimestamp,
    };
