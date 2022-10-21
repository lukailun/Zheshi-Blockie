enum LocationPermissionStatus {
  /// User has not yet made a choice with regards to this application
  notDetermined,

  /// This application is not authorized to use precise
  restricted,

  /// User has explicitly denied authorization for this application, or
  /// location services are disabled in Settings.
  denied,

  /// User has granted authorization to use their location at any
  /// time. Your app may be launched into the background by
  /// monitoring APIs such as visit monitoring, region monitoring,
  /// and significant location change monitoring.
  authorizedAlways,

  /// User has granted authorization to use their location only while
  /// they are using your app.
  authorizedWhenInUse,
}

/// Extension to [LocationPermissionStatus].
extension LocationPermissionStatusExtension on LocationPermissionStatus {
  /// Returns true if the permission is authorized.
  bool get authorized =>
      this == LocationPermissionStatus.authorizedAlways ||
      this == LocationPermissionStatus.authorizedWhenInUse;
}
