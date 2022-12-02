// Package imports:
import 'package:json_annotation/json_annotation.dart';

part 'country.g.dart';

@JsonSerializable(explicitToJson: true)
class Country {
  @JsonKey(name: 'id')
  int code;
  @JsonKey(name: 'name')
  String name;
  @JsonKey(name: 'alpha2')
  String alpha;

  bool get isChina => [156, 158, 344, 446].contains(code);

  Country({
    required this.code,
    required this.name,
    required this.alpha,
  });

  factory Country.fromJson(Map<String, dynamic> json) =>
      _$CountryFromJson(json);

  Map<String, dynamic> toJson() => _$CountryToJson(this);
}
