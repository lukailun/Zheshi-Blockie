// Dart imports:
import 'dart:html' show Geolocation, Geoposition, Navigator, Permissions;

// Project imports:
import 'package:blockie_app/data/apis/models/location/Location_settings.dart';
import 'package:blockie_app/data/apis/models/location/location.dart';
import 'package:blockie_app/data/apis/models/location/location_accuracy.dart';
import 'package:blockie_app/data/apis/models/location/location_permission_status.dart';

class LocationService {
  LocationService(Navigator navigator)
      : _geolocation = navigator.geolocation,
        _permissions = navigator.permissions;

  final Geolocation _geolocation;
  final Permissions? _permissions;

  final _accuracy = LocationAccuracy.high;

  Future<Location?> getLocation({LocationSettings? settings}) async {
    final result = await _geolocation.getCurrentPosition(
      enableHighAccuracy: (settings?.accuracy.index ?? _accuracy.index) >=
          LocationAccuracy.high.index,
    );
    return _toLocation(result);
  }

  Future<LocationPermissionStatus?> getPermissionStatus() async {
    final result =
        await _permissions!.query(<String, String>{'name': 'geolocation'});
    switch (result.state) {
      case 'granted':
        return LocationPermissionStatus.authorizedAlways;
      case 'prompt':
        return LocationPermissionStatus.notDetermined;
      case 'denied':
        return LocationPermissionStatus.denied;
      default:
        throw ArgumentError('Unknown permission ${result.state}.');
    }
  }

  Future<LocationPermissionStatus?> requestPermission() async {
    try {
      await _geolocation.getCurrentPosition();
      return LocationPermissionStatus.authorizedAlways;
    } catch (e) {
      return LocationPermissionStatus.denied;
    }
  }

  Location _toLocation(Geoposition result) {
    return Location(
      latitude: result.coords?.latitude?.toDouble(),
      longitude: result.coords?.longitude?.toDouble(),
      timestamp: result.timestamp?.toDouble(),
    );
  }
}
