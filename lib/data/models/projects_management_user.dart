// Package imports:
import 'package:blockie_app/data/models/wallet.dart';
import 'package:json_annotation/json_annotation.dart';

// Project imports:

part 'projects_management_user.g.dart';

@JsonSerializable(explicitToJson: true)
class ProjectsManagementUser {
  @JsonKey(name: 'phone')
  String phoneNumber;
  @JsonKey(name: 'in_whitelist')
  bool isQualified;
  @JsonKey(name: 'wallets')
  List<Wallet> wallets;

  ProjectsManagementUser({
    required this.phoneNumber,
    required this.isQualified,
    required this.wallets,
  });

  String? get walletAddress =>
      wallets.isNotEmpty ? wallets.first.address : null;

  factory ProjectsManagementUser.fromJson(Map<String, dynamic> json) =>
      _$ProjectsManagementUserFromJson(json);

  Map<String, dynamic> toJson() => _$ProjectsManagementUserToJson(this);
}
