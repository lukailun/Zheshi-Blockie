// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'issuer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Issuer _$IssuerFromJson(Map<String, dynamic> json) => Issuer(
      name: json['title'] as String,
      avatarPath: json['logo'] as String,
      ID: json['uid'] as String,
    );

Map<String, dynamic> _$IssuerToJson(Issuer instance) => <String, dynamic>{
      'title': instance.name,
      'uid': instance.ID,
      'logo': instance.avatarPath,
    };
