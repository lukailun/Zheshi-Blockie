// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Profile _$ProfileFromJson(Map<String, dynamic> json) => Profile(
      nfts: ProfileNfts.fromJson(json['nfts'] as Map<String, dynamic>),
      labels: (json['labels'] as List<dynamic>)
          .map((e) => ProfileLabel.fromJson(e as Map<String, dynamic>))
          .toList(),
      tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$ProfileToJson(Profile instance) => <String, dynamic>{
      'nfts': instance.nfts.toJson(),
      'labels': instance.labels.map((e) => e.toJson()).toList(),
      'tags': instance.tags,
    };
