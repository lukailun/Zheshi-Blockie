// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_nfts.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileNfts _$ProfileNftsFromJson(Map<String, dynamic> json) => ProfileNfts(
      imageNfts: (json['not_blockie'] as List<dynamic>?)
          ?.map((e) => ProfileNft.fromJson(e as Map<String, dynamic>))
          .toList(),
      videoNfts: (json['blockie'] as List<dynamic>?)
          ?.map((e) => ProfileNft.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ProfileNftsToJson(ProfileNfts instance) =>
    <String, dynamic>{
      'not_blockie': instance.imageNfts?.map((e) => e.toJson()).toList(),
      'blockie': instance.videoNfts?.map((e) => e.toJson()).toList(),
    };
