// Package imports:
import 'package:json_annotation/json_annotation.dart';

// Project imports:
import 'package:blockie_app/models/wallet.dart';

part 'project_management_user.g.dart';

@JsonSerializable(explicitToJson: true)
class ProjectManagementUser {
  @JsonKey(name: 'phone')
  String phoneNumber;
  @JsonKey(name: 'in_whitelist')
  bool isQualified;
  @JsonKey(name: 'wallets')
  List<Wallet> wallet;

  ProjectManagementUser({
    required this.phoneNumber,
    required this.isQualified,
    required this.wallet,
  });

  factory ProjectManagementUser.fromJson(Map<String, dynamic> json) => _$ProjectManagementUserFromJson(json);

  Map<String, dynamic> toJson() => _$ProjectManagementUserToJson(this);
}
