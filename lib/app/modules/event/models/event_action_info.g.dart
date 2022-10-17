// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_action_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventActionInfo _$EventActionInfoFromJson(Map<String, dynamic> json) =>
    EventActionInfo(
      ID: json['activity_uid'] as String,
      actionValue: json['action'] as String,
    );

Map<String, dynamic> _$EventActionInfoToJson(EventActionInfo instance) =>
    <String, dynamic>{
      'activity_uid': instance.ID,
      'action': instance.actionValue,
    };
