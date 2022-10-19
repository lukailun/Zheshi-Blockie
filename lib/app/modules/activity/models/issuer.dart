// Package imports:
import 'package:json_annotation/json_annotation.dart';

// Project imports:
import 'package:blockie_app/app/modules/activity/models/activity_step.dart';

part 'issuer.g.dart';

@JsonSerializable(explicitToJson: true)
class Issuer {
  @JsonKey(name: 'title')
  final String name;
  @JsonKey(name: 'uid')
  final String id;
  @JsonKey(name: 'logo')
  final String avatarPath;

  Issuer({
    required this.name,
    required this.avatarPath,
    required this.id,
  });

  factory Issuer.fromJson(Map<String, dynamic> json) => _$IssuerFromJson(json);

  Map<String, dynamic> toJson() => _$IssuerToJson(this);
}
