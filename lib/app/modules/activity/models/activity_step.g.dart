// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_step.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActivityStep _$ActivityStepFromJson(Map<String, dynamic> json) => ActivityStep(
      statusValue: json['status'] as int,
      title: json['name'] as String,
      ID: json['uid'] as String,
      actionInfo:
          ActivityActionInfo.fromJson(json['content'] as Map<String, dynamic>),
      time: json['time'] as String?,
      description: json['description'] as String?,
      imagePath: json['image'] as String?,
      activityStatusValue: json['activity_status'] as int?,
    );

Map<String, dynamic> _$ActivityStepToJson(ActivityStep instance) =>
    <String, dynamic>{
      'status': instance.statusValue,
      'name': instance.title,
      'description': instance.description,
      'time': instance.time,
      'image': instance.imagePath,
      'uid': instance.ID,
      'activity_status': instance.activityStatusValue,
      'content': instance.actionInfo.toJson(),
    };
