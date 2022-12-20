// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nft.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Nft _$NftFromJson(Map<String, dynamic> json) => Nft(
      id: json['uid'] as String,
      project: Project.fromJson(json['right'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$NftToJson(Nft instance) => <String, dynamic>{
      'uid': instance.id,
      'right': instance.project.toJson(),
    };
