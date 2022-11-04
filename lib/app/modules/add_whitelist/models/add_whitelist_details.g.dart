// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_whitelist_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddWhitelistDetails _$AddWhitelistDetailsFromJson(Map<String, dynamic> json) =>
    AddWhitelistDetails(
      user:
          ProjectsManagementUser.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AddWhitelistDetailsToJson(
        AddWhitelistDetails instance) =>
    <String, dynamic>{
      'user': instance.user.toJson(),
    };
