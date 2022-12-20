// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'projects_management_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProjectsManagementUser _$ProjectsManagementUserFromJson(
        Map<String, dynamic> json) =>
    ProjectsManagementUser(
      phoneNumber: json['phone'] as String,
      isQualified: json['in_whitelist'] as bool,
      wallets: (json['wallets'] as List<dynamic>)
          .map((e) => Wallet.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ProjectsManagementUserToJson(
        ProjectsManagementUser instance) =>
    <String, dynamic>{
      'phone': instance.phoneNumber,
      'in_whitelist': instance.isQualified,
      'wallets': instance.wallets.map((e) => e.toJson()).toList(),
    };
