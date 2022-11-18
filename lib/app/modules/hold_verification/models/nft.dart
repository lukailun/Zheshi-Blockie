// Package imports:
import 'package:json_annotation/json_annotation.dart';

// Project imports:
import 'package:blockie_app/app/modules/hold_verification/models/project.dart';

part 'nft.g.dart';

@JsonSerializable(explicitToJson: true)
class Nft {
  @JsonKey(name: 'uid')
  String id;
  @JsonKey(name: 'right')
  Project project;

  Nft({
    required this.id,
    required this.project,
  });

  factory Nft.fromJson(Map<String, dynamic> json) => _$NftFromJson(json);

  Map<String, dynamic> toJson() => _$NftToJson(this);
}
