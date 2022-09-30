import 'package:blockie_app/app/modules/event/models/event_step.dart';
import 'package:json_annotation/json_annotation.dart';

part 'issuer.g.dart';

@JsonSerializable(explicitToJson: true)
class Issuer {
  @JsonKey(name: 'title')
  final String name;
  @JsonKey(name: 'uid')
  final String ID;
  @JsonKey(name: 'logo')
  final String avatarPath;

  Issuer({
    required this.name,
    required this.avatarPath,
    required this.ID,
  });

  factory Issuer.fromJson(Map<String, dynamic> json) =>
      _$IssuerFromJson(json);

  Map<String, dynamic> toJson() => _$IssuerToJson(this);
}