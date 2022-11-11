// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subactivity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Subactivity _$SubactivityFromJson(Map<String, dynamic> json) => Subactivity(
      id: json['uid'] as String,
      startedTimestamp: json['started_at'] as int,
      endedTimestamp: json['ended_at'] as int,
      serverTimestamp: json['server_time'] as int,
      description: json['description'] as String,
      participantAvatarPaths: (json['participants'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      steps: (json['missions'] as List<dynamic>)
          .map((e) => SubactivityStep.fromJson(e as Map<String, dynamic>))
          .toList(),
      projects: (json['rights'] as List<dynamic>)
          .map((e) => Project.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SubactivityToJson(Subactivity instance) =>
    <String, dynamic>{
      'uid': instance.id,
      'started_at': instance.startedTimestamp,
      'ended_at': instance.endedTimestamp,
      'server_time': instance.serverTimestamp,
      'description': instance.description,
      'participants': instance.participantAvatarPaths,
      'missions': instance.steps.map((e) => e.toJson()).toList(),
      'rights': instance.projects.map((e) => e.toJson()).toList(),
    };
