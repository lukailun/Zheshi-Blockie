// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reverse_address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReverseAddress _$ReverseAddressFromJson(Map<String, dynamic> json) =>
    ReverseAddress(
      location: Location.fromJson(json['location'] as Map<String, dynamic>),
      administrativeDivisionInfo:
          AddressInfo.fromJson(json['ad_info'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ReverseAddressToJson(ReverseAddress instance) =>
    <String, dynamic>{
      'location': instance.location.toJson(),
      'ad_info': instance.administrativeDivisionInfo.toJson(),
    };

Location _$LocationFromJson(Map<String, dynamic> json) => Location(
      latitude: (json['lat'] as num).toDouble(),
      longitude: (json['lng'] as num).toDouble(),
    );

Map<String, dynamic> _$LocationToJson(Location instance) => <String, dynamic>{
      'lat': instance.latitude,
      'lng': instance.longitude,
    };

AddressInfo _$AddressInfoFromJson(Map<String, dynamic> json) => AddressInfo(
      countryCode: json['nation_code'] as String,
      areaCode: json['adcode'] as String?,
    );

Map<String, dynamic> _$AddressInfoToJson(AddressInfo instance) =>
    <String, dynamic>{
      'nation_code': instance.countryCode,
      'adcode': instance.areaCode,
    };
