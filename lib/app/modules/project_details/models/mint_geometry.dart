// Dart imports:
import 'dart:math';

// Package imports:
import 'package:json_annotation/json_annotation.dart';

part 'mint_geometry.g.dart';

@JsonSerializable(explicitToJson: true)
class MintGeometry {
  @JsonKey(name: 'lat')
  final double latitude;
  @JsonKey(name: 'lng')
  final double longitude;
  @JsonKey(name: 'radius')
  final int radius;

  MintGeometry({
    required this.latitude,
    required this.longitude,
    required this.radius,
  });

  bool isInArea(double latitude, double longitude) {
    final distance = _getDistance(latitude, longitude);
    return distance <= radius;
  }

  double _getDistance(double latitude, double longitude) {
    const earthRadius = 6378137.0;
    final selfLatitudeRadian = _getRadian(this.latitude);
    final latitudeRadian = _getRadian(latitude);
    final alphaLatitudeRadian = selfLatitudeRadian - latitudeRadian;
    final alphaLongitudeRadian =
        _getRadian(this.longitude) - _getRadian(longitude);
    final angle = 2 *
        asin(sqrt(pow(sin(alphaLatitudeRadian / 2), 2) +
            cos(selfLatitudeRadian) *
                cos(latitudeRadian) *
                pow(sin(alphaLongitudeRadian / 2), 2)));
    return angle * earthRadius;
  }

  double _getRadian(double degree) => degree * pi / 180.0;

  factory MintGeometry.fromJson(Map<String, dynamic> json) =>
      _$MintGeometryFromJson(json);

  Map<String, dynamic> toJson() => _$MintGeometryToJson(this);
}
