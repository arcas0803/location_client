// ------------------------------------------------------------
// -------------- Location FAILURES ---------------------------
// ------------------------------------------------------------

import 'package:common_classes/common_classes.dart';

/// Represents an location failure
///
/// This failures are not recovery failures.
///
sealed class LocationFailure extends Failure {
  LocationFailure({
    required super.message,
    required super.error,
    required super.stackTrace,
  });
}

/// Location permission denied forever failure
///
/// A subclass of [LocationFailure] that represents a location permission denied forever failure.
///
/// This failure is not recovery failure.
///
final class LocationPermissionDeniedForeverFailure extends LocationFailure {
  LocationPermissionDeniedForeverFailure()
      : super(
          message: 'Location permission denied forever',
          stackTrace: StackTrace.current,
          error: 'LocationPermissionDeniedForeverFailure',
        );
}

/// Location permission denied failure
///
/// A subclass of [LocationFailure] that represents a location permission denied failure.
///
/// This failure is not recovery failure.
///
final class LocationPermissionDeniedFailure extends LocationFailure {
  LocationPermissionDeniedFailure()
      : super(
          message: 'Location permission denied',
          stackTrace: StackTrace.current,
          error: 'LocationPermissionDeniedFailure',
        );
}

/// Location service disabled failure
///
/// A subclass of [LocationFailure] that represents a location service disabled failure.
///
/// This failure is not recovery failure.
///
final class LocationServiceDisabledFailure extends LocationFailure {
  LocationServiceDisabledFailure()
      : super(
          message: 'Location service disabled',
          stackTrace: StackTrace.current,
          error: 'LocationServiceDisabledFailure',
        );
}

/// Location service request timed out failure
///
/// A subclass of [LocationFailure] that represents a location service request timed out failure.
///
/// This failure is not recovery failure.
///
final class LocationServiceRequestTimedOutFailure extends LocationFailure {
  LocationServiceRequestTimedOutFailure()
      : super(
          message: 'Location service request timed out',
          stackTrace: StackTrace.current,
          error: 'LocationServiceRequestTimedOutFailure',
        );
}

/// Location service unknown failure
///
/// A subclass of [LocationFailure] that represents a location service unknown failure.
///
/// This failure is not recovery failure.
///
final class LocationServiceUnknownFailure extends LocationFailure {
  LocationServiceUnknownFailure()
      : super(
          message: 'Location service unknown',
          stackTrace: StackTrace.current,
          error: 'LocationServiceUnknownFailure',
        );
}

/// Location address not found failure
///
/// A subclass of [LocationFailure] that represents a location address not found failure.
///
/// This failure is not recovery failure.
///
final class LocationAddressNotFoundFailure extends LocationFailure {
  LocationAddressNotFoundFailure()
      : super(
          message: 'Location address not found',
          stackTrace: StackTrace.current,
          error: 'LocationAddressNotFoundFailure',
        );
}

/// Location from address not found failure
///
///  A subclass of [LocationFailure] that represents a location from address not found failure.
///
/// This failure is not recovery failure.
///
final class LocationFromAddressNotFoundFailure extends LocationFailure {
  LocationFromAddressNotFoundFailure()
      : super(
          message: 'Location from address not found',
          stackTrace: StackTrace.current,
          error: 'LocationFromAddressNotFoundFailure',
        );
}
