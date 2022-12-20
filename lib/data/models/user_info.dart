// Package imports:
import 'package:json_annotation/json_annotation.dart';

// Project imports:
import 'package:blockie_app/data/models/date.dart';
import 'package:blockie_app/data/models/gender.dart';
import 'package:blockie_app/data/models/region.dart';
import 'package:blockie_app/data/models/wallet.dart';
import 'package:blockie_app/extensions/extensions.dart';

part 'user_info.g.dart';

@JsonSerializable(explicitToJson: true)
class UserInfo {
  @JsonKey(name: 'nickname')
  final String username;
  @JsonKey(name: 'avatar')
  final String avatarPath;
  @JsonKey(name: 'phone')
  final String? phoneNumber;
  @JsonKey(name: 'level')
  final int? level;
  @JsonKey(name: 'uid')
  final String id;
  @JsonKey(name: 'wallets', defaultValue: [])
  final List<Wallet> wallets;
  @JsonKey(name: 'biography', defaultValue: '')
  final String bio;
  @JsonKey(name: 'roles', defaultValue: [])
  final List<String> roles;
  @JsonKey(name: 'gender', defaultValue: Gender.undefined)
  final Gender gender;
  @JsonKey(name: 'birth_date')
  final Date? birthday;
  @JsonKey(name: 'locale')
  final Region? region;

  UserInfo({
    required this.username,
    required this.avatarPath,
    required this.phoneNumber,
    required this.level,
    required this.id,
    required this.wallets,
    required this.bio,
    required this.roles,
    required this.gender,
    required this.birthday,
    required this.region,
  });

  bool get isStaff => roles.contains('staff');

  bool get hasSetGender => gender != Gender.undefined;

  String get avatarUrl => avatarPath.hostAdded;

  String? get walletAddress =>
      wallets.isNotEmpty ? wallets.first.address : null;

  factory UserInfo.fromJson(Map<String, dynamic> json) =>
      _$UserInfoFromJson(json);

  Map<String, dynamic> toJson() => _$UserInfoToJson(this);
}
