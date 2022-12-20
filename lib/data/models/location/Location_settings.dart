// Project imports:
import 'package:blockie_app/data/models/location/location_accuracy.dart';

class LocationSettings {
  LocationSettings({
    this.askForPermission = true,
    this.rationaleMessageForPermissionRequest =
        'The app needs to access your location',
    this.rationaleMessageForGPSRequest =
        'The app needs to access your location',
    this.useGooglePlayServices = true,
    this.askForGooglePlayServices = false,
    this.askForGPS = true,
    this.fallbackToGPS = true,
    this.ignoreLastKnownPosition = false,
    this.expirationDuration,
    this.expirationTime,
    this.fastestInterval = 500,
    this.interval = 1000,
    this.maxWaitTime,
    this.numUpdates,
    this.acceptableAccuracy,
    this.accuracy = LocationAccuracy.high,
    this.smallestDisplacement = 0,
    this.waitForAccurateLocation = true,
  });

  /// If set to true, the user will be prompted to grant permission to use location
  /// if not already granted.
  bool askForPermission;

  /// The message to display to the user when asking for permission to use location.
  /// Only valid on Android.
  /// For iOS, you have to change the permission in the Info.plist file.
  String rationaleMessageForPermissionRequest;

  /// The message to display to the user when asking for permission to use GPS.
  /// Only valid on Android.
  String rationaleMessageForGPSRequest;

  /// If set to true, the app will use Google Play Services to request location.
  /// If not available on the device, the app will fallback to GPS.
  /// Only valid on Android.
  bool useGooglePlayServices;

  /// If set to true, the app will request Google Play Services to request location.
  /// If not available on the device, the app will fallback to GPS.
  bool askForGooglePlayServices;

  /// If set to true, the app will request GPS to request location.
  /// Only valid on Android.
  bool askForGPS;

  /// If set to true, the app will fallback to GPS if Google Play Services is not
  /// available on the device.
  /// Only valid on Android.
  bool fallbackToGPS;

  /// If set to true, the app will ignore the last known position
  /// and request a fresh one
  bool ignoreLastKnownPosition;

  /// The duration of the location request.
  /// Only valid on Android.
  double? expirationDuration;

  /// The expiration time of the location request.
  /// Only valid on Android.
  double? expirationTime;

  /// The fastest interval between location updates.
  /// In milliseconds.
  /// Only valid on Android.
  double fastestInterval;

  /// The interval between location updates.
  /// In milliseconds.
  double interval;

  /// The maximum amount of time the app will wait for a location.
  /// In milliseconds.
  double? maxWaitTime;

  /// The number of location updates to request.
  /// Only valid on Android.
  int? numUpdates;

  /// The accuracy of the location request.
  LocationAccuracy accuracy;

  /// The smallest displacement between location updates.
  double smallestDisplacement;

  /// If set to true, the app will wait for an accurate location.
  /// Only valid on Android.
  bool waitForAccurateLocation;

  /// The accptable accuracy of the location request.
  /// Only valid on Android.
  double? acceptableAccuracy;
}
