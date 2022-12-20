// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nft.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Nft _$NftFromJson(Map<String, dynamic> json) => Nft(
      id: json['uid'] as String,
      project: Project.fromJson(json['right'] as Map<String, dynamic>),
      souvenirs: (json['souvenirs'] as List<dynamic>)
          .map((e) => Souvenir.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$NftToJson(Nft instance) => <String, dynamic>{
      'uid': instance.id,
      'right': instance.project.toJson(),
      'souvenirs': instance.souvenirs.map((e) => e.toJson()).toList(),
    };
