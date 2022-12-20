// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'region.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Region _$RegionFromJson(Map<String, dynamic> json) => Region(
      isChina: json['is_china'] as bool,
      areaCode: json['area_code'] as String? ?? '',
      countryCode: json['country_code'] as String? ?? '',
    );

Map<String, dynamic> _$RegionToJson(Region instance) => <String, dynamic>{
      'is_china': instance.isChina,
      'area_code': instance.areaCode,
      'country_code': instance.countryCode,
    };
