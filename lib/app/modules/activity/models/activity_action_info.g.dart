// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_action_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActivityActionInfo _$ActivityActionInfoFromJson(Map<String, dynamic> json) =>
    ActivityActionInfo(
      id: json['activity_uid'] as String?,
      actionValue: json['action'] as String,
    );

Map<String, dynamic> _$ActivityActionInfoToJson(ActivityActionInfo instance) =>
    <String, dynamic>{
      'activity_uid': instance.id,
      'action': instance.actionValue,
    };
