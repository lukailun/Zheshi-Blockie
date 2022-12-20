// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mint_geometry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MintGeometry _$MintGeometryFromJson(Map<String, dynamic> json) => MintGeometry(
      latitude: (json['lat'] as num).toDouble(),
      longitude: (json['lng'] as num).toDouble(),
      radius: json['radius'] as int,
    );

Map<String, dynamic> _$MintGeometryToJson(MintGeometry instance) =>
    <String, dynamic>{
      'lat': instance.latitude,
      'lng': instance.longitude,
      'radius': instance.radius,
    };
