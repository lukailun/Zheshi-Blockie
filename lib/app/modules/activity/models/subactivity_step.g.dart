// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subactivity_step.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubactivityStep _$SubactivityStepFromJson(Map<String, dynamic> json) =>
    SubactivityStep(
      id: json['action'] as String,
      category: json['category_cn'] as String,
      title: json['name'] as String,
      iconPath: json['icon_path'] as String,
      isCompleted: json['status'] as bool,
    );

Map<String, dynamic> _$SubactivityStepToJson(SubactivityStep instance) =>
    <String, dynamic>{
      'action': instance.id,
      'category_cn': instance.category,
      'name': instance.title,
      'icon_path': instance.iconPath,
      'status': instance.isCompleted,
    };
