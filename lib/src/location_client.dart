import 'package:common_classes/common_classes.dart';
import 'package:location_client/src/location_address.dart';
import 'package:location_client/src/location_position.dart';

abstract class LocationClient {
  /// Returns the current location of the user.
  ///
  /// It will check if the location service is enabled and if the permission is granted.
  ///
  /// If the location service is not enabled, it will request the user to enable it.
  ///
  /// If the permission is not granted, it will request the user to grant it.
  ///
  /// If the permission is granted, it will return the current location of the user.
  ///
  /// If the permission is not granted, it will return a [Failure].
  ///
  Future<Result<LocationPosition>> getCurrentPosition();

  /// Returns the last known location of the user.
  ///
  /// It will check if the location service is enabled and if the permission is granted.
  ///
  /// If the location service is not enabled, it will request the user to enable it.
  ///
  /// If the permission is not granted, it will request the user to grant it.
  ///
  /// If the permission is granted, it will return the last known location of the user.
  ///
  /// If the permission is not granted, it will return a [Failure].
  ///
  Future<Result<LocationPosition>> getLastKnownPosition();

  /// Requests the user to grant the location permission.
  ///
  /// If the permission is granted, it will return [Unit].
  ///
  /// If the permission is denied, it will return a [LocationPermissionDeniedFailure].
  ///
  /// If the permission is denied forever, it will return a [LocationPermissionDeniedForeverFailure].
  ///
  Future<Result<void>> requestPermission();

  /// Checks if the location permission is granted.
  ///
  /// If the location permission is granted, it will return [Unit].
  ///
  /// If the location permission is not granted, it will return a [Failure].
  ///
  /// If the permission is denied, it will return a [LocationPermissionDeniedFailure].
  ///
  /// If the permission is denied forever, it will return a [LocationPermissionDeniedForeverFailure].
  ///
  /// If something goes wrong, it will return a [LocationServiceUnknownFailure].
  ///
  Future<Result<void>> isPermissionGranted();

  /// Checks if the location service is enabled.
  ///
  /// If the location service is enabled, it will return [Unit].
  ///
  /// If the location service is not enabled, it will return a [LocationServiceDisabledFailure].
  ///
  /// If something goes wrong, it will return a [LocationServiceUnknownFailure].
  ///
  Future<Result<void>> isServiceEnabled();

  /// Listens to the location changes.
  ///
  /// Checks if the location service is enabled and if the permission is granted.
  ///
  /// If the location changes, it will return the new location.
  ///
  /// If something goes wrong, it will return a [Failure].
  ///
  Future<Result<Stream<LocationPosition>>> onLocationChanged();

  /// Opens the app settings.
  ///
  /// If the app settings are opened, it will return [Unit].
  ///
  /// If something goes wrong, it will return a [LocationServiceUnknownFailure].
  ///
  Future<Result<void>> openAppSettings();

  /// Opens the location settings.
  ///
  /// If the location settings are opened, it will return `true`.
  ///
  /// If the location settings are not opened, it will return `false`.
  ///
  /// If something goes wrong, it will return a [Failure].
  ///
  Future<Result<LocationAddress>> getAddressFromLocation({
    required LocationPosition location,
  });

  /// Returns the location from the address.
  ///
  /// If the location is returned, it will return the location.
  ///
  /// If something goes wrong, it will return a [Failure].
  ///
  Future<Result<LocationPosition>> getLocationFromAddress({
    required LocationAddress address,
  });
}
