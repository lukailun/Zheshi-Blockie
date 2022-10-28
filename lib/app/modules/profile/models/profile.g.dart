// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Profile _$ProfileFromJson(Map<String, dynamic> json) => Profile(
      nfts: ProfileNfts.fromJson(json['nfts'] as Map<String, dynamic>),
      tags: (json['tags'] as List<dynamic>)
          .map((e) => ProfileTag.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ProfileToJson(Profile instance) => <String, dynamic>{
      'nfts': instance.nfts.toJson(),
      'tags': instance.tags.map((e) => e.toJson()).toList(),
    };
