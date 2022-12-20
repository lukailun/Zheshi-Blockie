// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hold_verification_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HoldVerificationDetails _$HoldVerificationDetailsFromJson(
        Map<String, dynamic> json) =>
    HoldVerificationDetails(
      user:
          ProjectsManagementUser.fromJson(json['user'] as Map<String, dynamic>),
      nfts: (json['nfts'] as List<dynamic>)
          .map((e) => Nft.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$HoldVerificationDetailsToJson(
        HoldVerificationDetails instance) =>
    <String, dynamic>{
      'user': instance.user.toJson(),
      'nfts': instance.nfts.map((e) => e.toJson()).toList(),
    };
