// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Country _$CountryFromJson(Map<String, dynamic> json) => Country(
      code: json['id'] as int,
      name: json['name'] as String,
      alpha: json['alpha2'] as String,
    );

Map<String, dynamic> _$CountryToJson(Country instance) => <String, dynamic>{
      'id': instance.code,
      'name': instance.name,
      'alpha2': instance.alpha,
    };
