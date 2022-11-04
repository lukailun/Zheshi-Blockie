// Package imports:
import 'package:json_annotation/json_annotation.dart';

// Project imports:
import 'package:blockie_app/app/modules/profile/models/profile_label.dart';
import 'package:blockie_app/app/modules/profile/models/profile_nfts.dart';

part 'profile.g.dart';

@JsonSerializable(explicitToJson: true)
class Profile {
  @JsonKey(name: 'nfts')
  final ProfileNfts nfts;
  @JsonKey(name: 'labels')
  final List<ProfileLabel> labels;
  @JsonKey(name: 'tags')
  final List<String> tags;

  Profile({
    required this.nfts,
    required this.labels,
    required this.tags,
  });

  factory Profile.fromJson(Map<String, dynamic> json) =>
      _$ProfileFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileToJson(this);
}
