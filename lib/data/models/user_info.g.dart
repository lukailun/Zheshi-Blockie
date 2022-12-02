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
              .toList() ??
          [],
      bio: json['biography'] as String? ?? '',
      roles:
          (json['roles'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              [],
      gender: $enumDecodeNullable(_$GenderEnumMap, json['gender']) ??
          Gender.undefined,
      birthday: json['birth_date'] == null
          ? null
          : Date.fromJson(json['birth_date'] as Map<String, dynamic>),
      region: json['locale'] == null
          ? null
          : Region.fromJson(json['locale'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserInfoToJson(UserInfo instance) => <String, dynamic>{
      'nickname': instance.username,
      'avatar': instance.avatarPath,
      'phone': instance.phoneNumber,
      'level': instance.level,
      'uid': instance.id,
      'wallets': instance.wallets.map((e) => e.toJson()).toList(),
      'biography': instance.bio,
      'roles': instance.roles,
      'gender': _$GenderEnumMap[instance.gender]!,
      'birth_date': instance.birthday?.toJson(),
      'locale': instance.region?.toJson(),
    };

const _$GenderEnumMap = {
  Gender.undefined: 0,
  Gender.male: 1,
  Gender.female: 2,
};
