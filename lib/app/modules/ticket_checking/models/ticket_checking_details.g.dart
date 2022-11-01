// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ticket_checking_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TicketCheckingDetails _$TicketCheckingDetailsFromJson(
        Map<String, dynamic> json) =>
    TicketCheckingDetails(
      user:
          ProjectManagementUser.fromJson(json['user'] as Map<String, dynamic>),
      nfts: (json['nfts'] as List<dynamic>)
          .map((e) => Nft.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TicketCheckingDetailsToJson(
        TicketCheckingDetails instance) =>
    <String, dynamic>{
      'user': instance.user.toJson(),
      'nfts': instance.nfts.map((e) => e.toJson()).toList(),
    };
