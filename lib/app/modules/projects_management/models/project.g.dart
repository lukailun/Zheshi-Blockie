// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Project _$ProjectFromJson(Map<String, dynamic> json) => Project(
      name: json['name'] as String,
      summary: json['summary'] as String,
      description: json['description'] as String,
      id: json['uid'] as String,
      coverPath: json['cover'] as String,
      contract: json['contract'] as String,
      totalAmount: json['total_amount'] as int,
    );

Map<String, dynamic> _$ProjectToJson(Project instance) => <String, dynamic>{
      'name': instance.name,
      'summary': instance.summary,
      'description': instance.description,
      'uid': instance.id,
      'cover': instance.coverPath,
      'contract': instance.contract,
      'total_amount': instance.totalAmount,
    };
