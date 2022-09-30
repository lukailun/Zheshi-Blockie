// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'face_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FaceInfo _$FaceInfoFromJson(Map<String, dynamic> json) => FaceInfo(
      path: json['face_path'] as String,
      ID: json['uid'] as String,
    );

Map<String, dynamic> _$FaceInfoToJson(FaceInfo instance) => <String, dynamic>{
      'face_path': instance.path,
      'uid': instance.ID,
    };
