// Package imports:
import 'package:json_annotation/json_annotation.dart';

// Project imports:
import 'package:blockie_app/app/modules/profile/models/profile_nfts.dart';
import 'package:blockie_app/app/modules/profile/models/profile_tag.dart';

part 'profile.g.dart';

@JsonSerializable(explicitToJson: true)
class Profile {
  @JsonKey(name: 'nfts')
  final ProfileNfts nfts;
  @JsonKey(name: 'tags')
  final List<ProfileTag> tags;

  Profile({
    required this.nfts,
    required this.tags,
  });

  factory Profile.fromJson(Map<String, dynamic> json) =>
      _$ProfileFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileToJson(this);
}
