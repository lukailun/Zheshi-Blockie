// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'airdrop_nft_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AirdropNftDetails _$AirdropNftDetailsFromJson(Map<String, dynamic> json) =>
    AirdropNftDetails(
      user:
          ProjectsManagementUser.fromJson(json['user'] as Map<String, dynamic>),
      activity: Activity.fromJson(json['activity'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AirdropNftDetailsToJson(AirdropNftDetails instance) =>
    <String, dynamic>{
      'user': instance.user.toJson(),
      'activity': instance.activity.toJson(),
    };
