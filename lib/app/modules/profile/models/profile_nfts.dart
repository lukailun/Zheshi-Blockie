// Package imports:
import 'package:blockie_app/app/modules/profile/models/profile_nft.dart';
import 'package:json_annotation/json_annotation.dart';

part 'profile_nfts.g.dart';

@JsonSerializable(explicitToJson: true)
class ProfileNfts {
  @JsonKey(name: 'not_blockie')
  final List<ProfileNft>? imageNfts;
  @JsonKey(name: 'blockie')
  final List<ProfileNft>? videoNfts;

  ProfileNfts({
    required this.imageNfts,
    required this.videoNfts,
  });

  factory ProfileNfts.fromJson(Map<String, dynamic> json) =>
      _$ProfileNftsFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileNftsToJson(this);
}
