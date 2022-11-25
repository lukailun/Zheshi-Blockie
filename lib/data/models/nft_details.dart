// Package imports:
import 'package:json_annotation/json_annotation.dart';

part 'nft_details.g.dart';

@JsonSerializable(explicitToJson: true)
class NftDetails {
  @JsonKey(name: 'category_cn')
  final String category;

  NftDetails({
    required this.category,
  });

  factory NftDetails.fromJson(Map<String, dynamic> json) =>
      _$NftDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$NftDetailsToJson(this);
}
