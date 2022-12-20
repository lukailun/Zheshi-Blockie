// Package imports:
import 'package:json_annotation/json_annotation.dart';

// Project imports:
import 'package:blockie_app/extensions/extensions.dart';

part 'profile_nft.g.dart';

@JsonSerializable(explicitToJson: true)
class ProfileNft {
  @JsonKey(name: 'cover')
  final String coverPath;
  @JsonKey(name: 'uid')
  final String id;

  ProfileNft({
    required this.coverPath,
    required this.id,
  });

  String get coverUrl => coverPath.hostAdded;

  factory ProfileNft.fromJson(Map<String, dynamic> json) =>
      _$ProfileNftFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileNftToJson(this);
}
