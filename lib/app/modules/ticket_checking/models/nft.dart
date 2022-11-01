// Package imports:
import 'package:json_annotation/json_annotation.dart';

// Project imports:
import 'package:blockie_app/app/modules/ticket_checking/models/project.dart';
import 'package:blockie_app/app/modules/ticket_checking/models/souvenir.dart';

part 'nft.g.dart';

@JsonSerializable(explicitToJson: true)
class Nft {
  @JsonKey(name: 'uid')
  String id;
  @JsonKey(name: 'activity')
  Project project;
  @JsonKey(name: 'souvenirs')
  List<Souvenir> souvenirs;

  Nft({
    required this.id,
    required this.project,
    required this.souvenirs,
  });

  factory Nft.fromJson(Map<String, dynamic> json) => _$NftFromJson(json);

  Map<String, dynamic> toJson() => _$NftToJson(this);
}
