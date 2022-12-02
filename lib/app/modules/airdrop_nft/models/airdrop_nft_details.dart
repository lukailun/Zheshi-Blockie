// Package imports:
import 'package:json_annotation/json_annotation.dart';

// Project imports:
import 'package:blockie_app/app/modules/airdrop_nft/models/activity.dart';
import 'package:blockie_app/data/models/projects_management_user.dart';

part 'airdrop_nft_details.g.dart';

@JsonSerializable(explicitToJson: true)
class AirdropNftDetails {
  @JsonKey(name: 'user')
  ProjectsManagementUser user;
  @JsonKey(name: 'activity')
  Activity activity;

  AirdropNftDetails({
    required this.user,
    required this.activity,
  });

  factory AirdropNftDetails.fromJson(Map<String, dynamic> json) =>
      _$AirdropNftDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$AirdropNftDetailsToJson(this);
}
