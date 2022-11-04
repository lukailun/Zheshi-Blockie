// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserInfo _$UserInfoFromJson(Map<String, dynamic> json) => UserInfo(
      username: json['nickname'] as String,
      avatarPath: json['avatar'] as String,
      phoneNumber: json['phone'] as String?,
      level: json['level'] as int?,
      id: json['uid'] as String,
      wallets: (json['wallets'] as List<dynamic>?)
          ?.map((e) => Wallet.fromJson(e as Map<String, dynamic>))
          .toList(),
      bio: json['biography'] as String?,
      roles:
          (json['roles'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$UserInfoToJson(UserInfo instance) => <String, dynamic>{
      'nickname': instance.username,
      'avatar': instance.avatarPath,
      'phone': instance.phoneNumber,
      'level': instance.level,
      'uid': instance.id,
      'wallets': instance.wallets?.map((e) => e.toJson()).toList(),
      'biography': instance.bio,
      'roles': instance.roles,
    };
