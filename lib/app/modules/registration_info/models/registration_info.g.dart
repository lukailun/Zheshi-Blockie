// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'registration_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegistrationInfo _$RegistrationInfoFromJson(Map<String, dynamic> json) =>
    RegistrationInfo(
      entryNumber: json['number'] as String,
      faceInfos: (json['faces'] as List<dynamic>)
          .map((e) => FaceInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
      hasSigned: json['is_signed'] as bool,
      exampleNumber: json['eg_number'] as String,
    );

Map<String, dynamic> _$RegistrationInfoToJson(RegistrationInfo instance) =>
    <String, dynamic>{
      'number': instance.entryNumber,
      'is_signed': instance.hasSigned,
      'faces': instance.faceInfos.map((e) => e.toJson()).toList(),
      'eg_number': instance.exampleNumber,
    };
