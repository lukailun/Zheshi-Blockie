// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subactivity_step.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubactivityStep _$SubactivityStepFromJson(Map<String, dynamic> json) =>
    SubactivityStep(
      type: $enumDecode(_$SubactivityStepTypeEnumMap, json['action']),
      category: json['category_cn'] as String,
      title: json['name'] as String,
      iconPath: json['icon_path'] as String,
      isCompleted: json['status'] as bool,
    );

Map<String, dynamic> _$SubactivityStepToJson(SubactivityStep instance) =>
    <String, dynamic>{
      'action': _$SubactivityStepTypeEnumMap[instance.type]!,
      'category_cn': instance.category,
      'name': instance.title,
      'icon_path': instance.iconPath,
      'status': instance.isCompleted,
    };

const _$SubactivityStepTypeEnumMap = {
  SubactivityStepType.login: 'login',
  SubactivityStepType.register: 'signup',
  SubactivityStepType.finish: 'finished_match',
  SubactivityStepType.volunteer: 'volunteer',
  SubactivityStepType.submitToFinish: 'manual_finish',
};
