// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'face_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FaceInfo _$FaceInfoFromJson(Map<String, dynamic> json) => FaceInfo(
      ID: json['uid'] as String,
      path: json['face_path'] as String,
    );

Map<String, dynamic> _$FaceInfoToJson(FaceInfo instance) => <String, dynamic>{
      'uid': instance.ID,
      'face_path': instance.path,
    };
