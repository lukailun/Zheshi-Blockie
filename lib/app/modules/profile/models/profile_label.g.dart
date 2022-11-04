// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_label.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileLabel _$ProfileLabelFromJson(Map<String, dynamic> json) => ProfileLabel(
      iconPath: json['icon_path'] as String,
      name: json['name_cn'] as String,
      id: json['uid'] as String,
    );

Map<String, dynamic> _$ProfileLabelToJson(ProfileLabel instance) =>
    <String, dynamic>{
      'icon_path': instance.iconPath,
      'name_cn': instance.name,
      'uid': instance.id,
    };
