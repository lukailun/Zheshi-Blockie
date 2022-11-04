// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nft.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Nft _$NftFromJson(Map<String, dynamic> json) => Nft(
      id: json['uid'] as String,
      activity: Activity.fromJson(json['activity'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$NftToJson(Nft instance) => <String, dynamic>{
      'uid': instance.id,
      'activity': instance.activity.toJson(),
    };
