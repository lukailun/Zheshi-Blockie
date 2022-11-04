// Package imports:
import 'package:json_annotation/json_annotation.dart';

// Project imports:
import 'package:blockie_app/extensions/extensions.dart';
import 'package:blockie_app/models/wallet.dart';

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
  @JsonKey(name: 'wallets')
  final List<Wallet>? wallets;
  @JsonKey(name: 'biography')
  final String? bio;
  @JsonKey(name: 'roles')
  final List<String>? roles;

  UserInfo({
    required this.username,
    required this.avatarPath,
    required this.phoneNumber,
    required this.level,
    required this.id,
    required this.wallets,
    required this.bio,
    required this.roles,
  });

  bool get isStaff => roles?.contains('staff') ?? false;

  String get avatarUrl => avatarPath.hostAdded;

  String? get walletAddress =>
      (wallets ?? []).isNotEmpty ? wallets?.first.address : null;

  factory UserInfo.fromJson(Map<String, dynamic> json) =>
      _$UserInfoFromJson(json);

  Map<String, dynamic> toJson() => _$UserInfoToJson(this);
}
