// Dart imports:
import 'dart:convert';

// Package imports:
import 'package:city_pickers/city_pickers.dart';
import 'package:json_annotation/json_annotation.dart';

// Project imports:
import 'package:blockie_app/extensions/extensions.dart';
import 'package:blockie_app/utils/city_pickers_utils.dart';

part 'region.g.dart';

@JsonSerializable(explicitToJson: true)
class Region {
  @JsonKey(name: 'is_china')
  bool isChina;
  @JsonKey(name: 'area_code', defaultValue: '')
  String areaCode;
  @JsonKey(name: 'country_code', defaultValue: '')
  String countryCode;

  Region({
    required this.isChina,
    required this.areaCode,
    required this.countryCode,
  });

  String? get region =>
      CityPickersUtils.getRegion(isChina ? areaCode : countryCode);

  String get code => isChina ? areaCode : countryCode;

  String get toJsonString => jsonEncode(this);

  factory Region.fromJson(Map<String, dynamic> json) => _$RegionFromJson(json);

  Map<String, dynamic> toJson() => _$RegionToJson(this);
}
