// Package imports:
import 'package:blockie_app/app/modules/profile/models/profile_nfts.dart';
import 'package:json_annotation/json_annotation.dart';

part 'profile.g.dart';

@JsonSerializable(explicitToJson: true)
class Profile {
  @JsonKey(name: 'nfts')
  final ProfileNfts nfts;

  Profile({
    required this.nfts,
  });

  factory Profile.fromJson(Map<String, dynamic> json) =>
      _$ProfileFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileToJson(this);
}
