// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_tag.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileTag _$ProfileTagFromJson(Map<String, dynamic> json) => ProfileTag(
      iconPath: json['icon_path'] as String,
      name: json['name_cn'] as String,
      id: json['name'] as String,
    );

Map<String, dynamic> _$ProfileTagToJson(ProfileTag instance) =>
    <String, dynamic>{
      'icon_path': instance.iconPath,
      'name_cn': instance.name,
      'name': instance.id,
    };
