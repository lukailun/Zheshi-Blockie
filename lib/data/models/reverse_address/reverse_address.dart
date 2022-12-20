// Package imports:
import 'package:json_annotation/json_annotation.dart';

part 'reverse_address.g.dart';

@JsonSerializable(explicitToJson: true)
class ReverseAddress {
  @JsonKey(name: 'location')
  Location location;
  @JsonKey(name: 'ad_info')
  AddressInfo administrativeDivisionInfo;

  bool get isChina => administrativeDivisionInfo.countryCode == '156';

  ReverseAddress({
    required this.location,
    required this.administrativeDivisionInfo,
  });

  factory ReverseAddress.fromJson(Map<String, dynamic> json) =>
      _$ReverseAddressFromJson(json);

  Map<String, dynamic> toJson() => _$ReverseAddressToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Location {
  @JsonKey(name: 'lat')
  double latitude;
  @JsonKey(name: 'lng')
  double longitude;

  Location({
    required this.latitude,
    required this.longitude,
  });

  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);

  Map<String, dynamic> toJson() => _$LocationToJson(this);
}

@JsonSerializable(explicitToJson: true)
class AddressInfo {
  @JsonKey(name: 'nation_code')
  String countryCode;
  @JsonKey(name: 'adcode')
  String? areaCode;

  AddressInfo({
    required this.countryCode,
    this.areaCode,
  });

  factory AddressInfo.fromJson(Map<String, dynamic> json) =>
      _$AddressInfoFromJson(json);

  Map<String, dynamic> toJson() => _$AddressInfoToJson(this);
}
