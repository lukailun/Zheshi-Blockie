// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'issuer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Issuer _$IssuerFromJson(Map<String, dynamic> json) => Issuer(
      id: json['uid'] as String,
      title: json['title'] as String,
      summary: json['summary'] as String?,
      logoPath: json['logo'] as String,
    );

Map<String, dynamic> _$IssuerToJson(Issuer instance) => <String, dynamic>{
      'uid': instance.id,
      'title': instance.title,
      'summary': instance.summary,
      'logo': instance.logoPath,
    };
