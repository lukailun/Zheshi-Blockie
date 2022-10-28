// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      phoneNumber: json['phone'] as String,
      isQualified: json['in_whitelist'] as bool,
      wallet: (json['wallets'] as List<dynamic>)
          .map((e) => Wallet.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'phone': instance.phoneNumber,
      'in_whitelist': instance.isQualified,
      'wallets': instance.wallet.map((e) => e.toJson()).toList(),
    };
