// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_step.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventStep _$EventStepFromJson(Map<String, dynamic> json) => EventStep(
      statusValue: json['status'] as int,
      title: json['name'] as String,
      ID: json['uid'] as String,
      time: json['time'] as String?,
      description: json['description'] as String?,
      imagePath: json['image'] as String?,
      eventStatusValue: json['activity_status'] as int?,
    );

Map<String, dynamic> _$EventStepToJson(EventStep instance) => <String, dynamic>{
      'status': instance.statusValue,
      'name': instance.title,
      'description': instance.description,
      'time': instance.time,
      'image': instance.imagePath,
      'uid': instance.ID,
      'activity_status': instance.eventStatusValue,
    };
