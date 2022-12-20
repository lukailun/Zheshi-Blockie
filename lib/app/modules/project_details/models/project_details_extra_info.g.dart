// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_details_extra_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProjectDetailsExtraInfo _$ProjectDetailsExtraInfoFromJson(
        Map<String, dynamic> json) =>
    ProjectDetailsExtraInfo(
      ruleInfo: json['rules'] == null
          ? null
          : MintRuleInfo.fromJson(json['rules'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ProjectDetailsExtraInfoToJson(
        ProjectDetailsExtraInfo instance) =>
    <String, dynamic>{
      'rules': instance.ruleInfo?.toJson(),
    };
