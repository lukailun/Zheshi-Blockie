// Package imports:
import 'package:json_annotation/json_annotation.dart';

// Project imports:
import 'package:blockie_app/extensions/extensions.dart';

part 'issuer.g.dart';

@JsonSerializable(explicitToJson: true)
class Issuer {
  @JsonKey(name: 'uid')
  String id;
  @JsonKey(name: 'title')
  String title;
  @JsonKey(name: 'summary')
  String? summary;
  @JsonKey(name: 'logo')
  String logoPath;

  Issuer({
    required this.id,
    required this.title,
    required this.summary,
    required this.logoPath,
  });

  String? get logoUrl =>
      (logoPath ?? '').isNotEmpty ? (logoPath ?? '').hostAdded : null;

  factory Issuer.fromJson(Map<String, dynamic> json) => _$IssuerFromJson(json);

  Map<String, dynamic> toJson() => _$IssuerToJson(this);
}
