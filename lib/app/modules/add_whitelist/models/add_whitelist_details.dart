// Package imports:
import 'package:json_annotation/json_annotation.dart';

// Project imports:
import 'package:blockie_app/data/models/projects_management_user.dart';

part 'add_whitelist_details.g.dart';

@JsonSerializable(explicitToJson: true)
class AddWhitelistDetails {
  @JsonKey(name: 'user')
  ProjectsManagementUser user;

  AddWhitelistDetails({
    required this.user,
  });

  factory AddWhitelistDetails.fromJson(Map<String, dynamic> json) =>
      _$AddWhitelistDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$AddWhitelistDetailsToJson(this);
}
