// Package imports:
import 'package:json_annotation/json_annotation.dart';

// Project imports:
import 'package:blockie_app/app/modules/hold_verification/models/nft.dart';
import 'package:blockie_app/models/projects_management_user.dart';

part 'hold_verification_details.g.dart';

@JsonSerializable(explicitToJson: true)
class HoldVerificationDetails {
  @JsonKey(name: 'user')
  ProjectsManagementUser user;
  @JsonKey(name: 'nfts')
  List<Nft> nfts;

  HoldVerificationDetails({
    required this.user,
    required this.nfts,
  });

  factory HoldVerificationDetails.fromJson(Map<String, dynamic> json) =>
      _$HoldVerificationDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$HoldVerificationDetailsToJson(this);
}
