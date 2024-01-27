import 'dart:async';

import 'package:common_classes/common_classes.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:geolocator/geolocator.dart';
import 'package:location_client/src/location_address.dart';
import 'package:location_client/src/location_client.dart';
import 'package:location_client/src/location_failure.dart';
import 'package:location_client/src/location_position.dart';
import 'package:logger/logger.dart';

class LocationClientImpl implements LocationClient {
  final Logger? _logger;

  final FutureOr<void> Function(Failure)? _telemetryOnError;

  final FutureOr<void> Function()? _telemetryOnSuccess;

  LocationClientImpl({
    Logger? logger,
    FutureOr<void> Function(Failure)? telemetryOnError,
    FutureOr<void> Function()? telemetryOnSuccess,
  })  : _logger = logger,
        _telemetryOnError = telemetryOnError,
        _telemetryOnSuccess = telemetryOnSuccess;

  @override
  Future<Result<LocationAddress>> getAddressFromLocation(
      {required LocationPosition location}) async {
    _logger?.d(
      '[START] Getting address from location - ${location.toString()}',
    );

    return Result.asyncGuard(() async {
      final List<geocoding.Placemark> placemarks =
          await geocoding.placemarkFromCoordinates(
        location.latitude,
        location.longitude,
      );

      if (placemarks.isEmpty) {
        final failure = LocationFromAddressNotFoundFailure();

        _logger?.e(
          '[ERROR] Getting address from location - ${location.toString()} - ${failure.toString()}',
        );

        _telemetryOnError?.call(failure);

        throw failure;
      }

      final placemark = placemarks.first;

      final address = LocationAddress(
        street: placemark.street ?? '',
        city: placemark.locality ?? '',
        state: placemark.administrativeArea ?? '',
        country: placemark.country ?? '',
        postalCode: placemark.postalCode ?? '',
      );

      _logger?.d(
        '[END] Getting address from location - ${location.toString()} - ${address.toString()}',
      );

      _telemetryOnSuccess?.call();

      return address;
    }, onError: (e, s) {
      if (e is Failure) {
        return e;
      }

      final failure = LocationServiceUnknownFailure();

      _logger?.e(
        '[ERROR] Getting address from location - ${location.toString()} - ${failure.toString()}',
      );

      _telemetryOnError?.call(failure);

      return failure;
    });
  }

  @override
  Future<Result<LocationPosition>> getCurrentPosition() async {
    _logger?.d(
      '[START] Getting current position',
    );

    return Result.asyncGuard(
      () async {
        final permissionResult = await isPermissionGranted();
        // Check permission
        if (permissionResult.isError) {
          // If permission is denied but not forever, request permission
          if (permissionResult.getErrorOrThrow()
              is LocationPermissionDeniedFailure) {
            final requestPermissionResult = await requestPermission();

            // If request permission fails, return failure
            if (requestPermissionResult.isError) {
              throw requestPermissionResult.getErrorOrThrow();
            }
          } else {
            // If permission is denied forever, return failure
            throw permissionResult.getErrorOrThrow();
          }
        }

        // Check service
        final isServiceEnabledResult = await isServiceEnabled();

        if (isServiceEnabledResult.isError) {
          throw isServiceEnabledResult.getErrorOrThrow();
        }

        final position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );

        final location = LocationPosition(
          latitude: position.latitude,
          longitude: position.longitude,
          timestamp: position.timestamp,
        );

        _logger?.d(
          '[END] Getting current position - ${location.toString()}',
        );

        _telemetryOnSuccess?.call();

        return location;
      },
      onError: (e, s) {
        if (e is Failure) {
          return e;
        }

        final failure = LocationServiceUnknownFailure();

        _logger?.e(
          '[ERROR] Getting current position - ${failure.toString()}',
        );

        _telemetryOnError?.call(failure);

        return failure;
      },
    );
  }

  @override
  Future<Result<LocationPosition>> getLastKnownPosition() async {
    _logger?.d(
      '[START] Getting current position',
    );

    return Result.asyncGuard(
      () async {
        final permissionResult = await isPermissionGranted();
        // Check permission
        if (permissionResult.isError) {
          // If permission is denied but not forever, request permission
          if (permissionResult.getErrorOrThrow()
              is LocationPermissionDeniedFailure) {
            final requestPermissionResult = await requestPermission();

            // If request permission fails, return failure
            if (requestPermissionResult.isError) {
              throw requestPermissionResult.getErrorOrThrow();
            }
          } else {
            // If permission is denied forever, return failure
            throw permissionResult.getErrorOrThrow();
          }
        }

        // Check service
        final isServiceEnabledResult = await isServiceEnabled();

        if (isServiceEnabledResult.isError) {
          throw isServiceEnabledResult.getErrorOrThrow();
        }

        final position = await Geolocator.getLastKnownPosition();

        if (position == null) {
          final failure = LocationServiceUnknownFailure();

          _logger?.e(
            '[ERROR] Getting current position - ${failure.toString()}',
          );

          _telemetryOnError?.call(failure);

          throw failure;
        }

        final location = LocationPosition(
          latitude: position.latitude,
          longitude: position.longitude,
          timestamp: position.timestamp,
        );

        _logger?.d(
          '[END] Getting current position - ${location.toString()}',
        );

        _telemetryOnSuccess?.call();

        return location;
      },
      onError: (e, s) {
        if (e is Failure) {
          return e;
        }

        final failure = LocationServiceUnknownFailure();

        _logger?.e(
          '[ERROR] Getting current position - ${failure.toString()}',
        );

        _telemetryOnError?.call(failure);

        return failure;
      },
    );
  }

  @override
  Future<Result<LocationPosition>> getLocationFromAddress(
      {required LocationAddress address}) async {
    _logger?.d(
      '[START] Getting location from address - ${address.toString()}',
    );

    return Result.asyncGuard(
      () async {
        final List<geocoding.Location> locations =
            await geocoding.locationFromAddress(
          address.fullAddress,
        );

        if (locations.isEmpty) {
          final failure = LocationFromAddressNotFoundFailure();

          _logger?.e(
            '[ERROR] Getting location from address - ${address.toString()} - ${failure.toString()}',
          );

          _telemetryOnError?.call(failure);

          throw failure;
        }

        final location = LocationPosition(
          latitude: locations.first.latitude,
          longitude: locations.first.longitude,
          timestamp: DateTime.now(),
        );

        _logger?.d(
          '[END] Getting location from address - ${address.toString()} - ${location.toString()}',
        );

        _telemetryOnSuccess?.call();

        return location;
      },
      onError: (e, s) {
        if (e is Failure) {
          return e;
        }

        final failure = LocationServiceUnknownFailure();

        _logger?.e(
          '[ERROR] Getting location from address - ${address.toString()} - ${failure.toString()}',
        );

        _telemetryOnError?.call(failure);

        return failure;
      },
    );
  }

  @override
  Future<Result<void>> isPermissionGranted() async {
    _logger?.d(
      '[START] Checking if location permission is granted',
    );

    return Result.asyncGuard(() async {
      final isPermissionGranted = await Geolocator.checkPermission();

      if (isPermissionGranted == LocationPermission.denied) {
        final failure = LocationPermissionDeniedFailure();

        _logger?.e(
          '[ERROR] Checking if location permission is granted - ${failure.toString()}',
        );

        _telemetryOnError?.call(failure);

        throw failure;
      }

      if (isPermissionGranted == LocationPermission.deniedForever) {
        final failure = LocationPermissionDeniedForeverFailure();

        _logger?.e(
          '[ERROR] Checking if location permission is granted - ${failure.toString()}',
        );

        _telemetryOnError?.call(failure);

        throw failure;
      }

      _logger?.d(
        '[END] Checking if location permission is granted',
      );

      _telemetryOnSuccess?.call();
    }, onError: (e, s) {
      if (e is Failure) {
        return e;
      }

      final failure = LocationServiceUnknownFailure();

      _logger?.e(
        '[ERROR] Checking if location permission is granted - ${failure.toString()}',
      );

      _telemetryOnError?.call(failure);

      return failure;
    });
  }

  @override
  Future<Result<void>> isServiceEnabled() async {
    _logger?.d(
      '[START] Checking if location service is enabled',
    );

    return Result.asyncGuard(() async {
      final isServiceEnabled = await Geolocator.isLocationServiceEnabled();

      if (!isServiceEnabled) {
        final failure = LocationServiceDisabledFailure();

        _logger?.e(
          '[ERROR] Checking if location service is enabled - ${failure.toString()}',
        );

        _telemetryOnError?.call(failure);

        throw failure;
      }

      _logger?.d(
        '[END] Checking if location service is enabled',
      );

      _telemetryOnSuccess?.call();
    }, onError: (e, s) {
      if (e is Failure) {
        return e;
      }

      final failure = LocationServiceUnknownFailure();

      _logger?.e(
        '[ERROR] Checking if location service is enabled - ${failure.toString()}',
      );

      _telemetryOnError?.call(failure);

      return failure;
    });
  }

  @override
  Future<Result<Stream<LocationPosition>>> onLocationChanged() async {
    _logger?.d(
      '[START] Getting current position',
    );

    return Result.asyncGuard(
      () async {
        final permissionResult = await isPermissionGranted();
        // Check permission
        if (permissionResult.isError) {
          // If permission is denied but not forever, request permission
          if (permissionResult.getErrorOrThrow()
              is LocationPermissionDeniedFailure) {
            final requestPermissionResult = await requestPermission();

            // If request permission fails, return failure
            if (requestPermissionResult.isError) {
              throw requestPermissionResult.getErrorOrThrow();
            }
          } else {
            // If permission is denied forever, return failure
            throw permissionResult.getErrorOrThrow();
          }
        }

        // Check service
        final isServiceEnabledResult = await isServiceEnabled();

        if (isServiceEnabledResult.isError) {
          throw isServiceEnabledResult.getErrorOrThrow();
        }

        final position = Geolocator.getPositionStream(
          locationSettings: const LocationSettings(
            accuracy: LocationAccuracy.high,
            distanceFilter: 10,
          ),
        );

        final location = position.map((event) {
          return LocationPosition(
            latitude: event.latitude,
            longitude: event.longitude,
            timestamp: event.timestamp,
          );
        });

        _logger?.d(
          '[END] Getting current position - ${location.toString()}',
        );

        _telemetryOnSuccess?.call();

        return location;
      },
      onError: (e, s) {
        if (e is Failure) {
          return e;
        }

        final failure = LocationServiceUnknownFailure();

        _logger?.e(
          '[ERROR] Getting current position - ${failure.toString()}',
        );

        _telemetryOnError?.call(failure);

        return failure;
      },
    );
  }

  @override
  Future<Result<void>> openAppSettings() async {
    _logger?.d(
      '[START] Opening app settings',
    );

    return Result.asyncGuard(() async {
      final isOpened = await Geolocator.openAppSettings();

      if (!isOpened) {
        final failure = LocationServiceUnknownFailure();

        _logger?.e(
          '[ERROR] Opening app settings - ${failure.toString()}',
        );

        _telemetryOnError?.call(failure);

        throw failure;
      }

      _logger?.d(
        '[END] Opening app settings',
      );

      _telemetryOnSuccess?.call();
    }, onError: (e, s) {
      if (e is Failure) {
        return e;
      }

      final failure = LocationServiceUnknownFailure();

      _logger?.e(
        '[ERROR] Opening app settings - ${failure.toString()}',
      );

      _telemetryOnError?.call(failure);

      return failure;
    });
  }

  @override
  Future<Result<void>> requestPermission() async {
    _logger?.d(
      '[START] Requesting location permission',
    );

    return Result.asyncGuard(() async {
      final permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        final failure = LocationPermissionDeniedFailure();

        _logger?.e(
          '[ERROR] Requesting location permission - ${failure.toString()}',
        );

        _telemetryOnError?.call(failure);

        throw failure;
      }

      if (permission == LocationPermission.deniedForever) {
        final failure = LocationPermissionDeniedForeverFailure();

        _logger?.e(
          '[ERROR] Requesting location permission - ${failure.toString()}',
        );

        _telemetryOnError?.call(failure);

        throw failure;
      }

      _logger?.d(
        '[END] Requesting location permission',
      );

      _telemetryOnSuccess?.call();
    }, onError: (e, s) {
      if (e is Failure) {
        return e;
      }

      final failure = LocationServiceUnknownFailure();

      _logger?.e(
        '[ERROR] Requesting location permission - ${failure.toString()}',
      );

      _telemetryOnError?.call(failure);

      return failure;
    });
  }
}
