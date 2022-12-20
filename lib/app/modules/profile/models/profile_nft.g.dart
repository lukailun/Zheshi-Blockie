// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_nft.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileNft _$ProfileNftFromJson(Map<String, dynamic> json) => ProfileNft(
      coverPath: json['cover'] as String,
      id: json['uid'] as String,
    );

Map<String, dynamic> _$ProfileNftToJson(ProfileNft instance) =>
    <String, dynamic>{
      'cover': instance.coverPath,
      'uid': instance.id,
    };
