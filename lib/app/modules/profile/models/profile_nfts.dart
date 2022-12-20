// Package imports:
import 'package:json_annotation/json_annotation.dart';

// Project imports:
import 'package:blockie_app/app/modules/profile/models/profile_nft.dart';

part 'profile_nfts.g.dart';

@JsonSerializable(explicitToJson: true)
class ProfileNfts {
  @JsonKey(name: 'not_blockie')
  final List<ProfileNft>? sportNfts;
  @JsonKey(name: 'blockie')
  final List<ProfileNft>? videoNfts;

  ProfileNfts({
    required this.sportNfts,
    required this.videoNfts,
  });

  factory ProfileNfts.fromJson(Map<String, dynamic> json) =>
      _$ProfileNftsFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileNftsToJson(this);
}
