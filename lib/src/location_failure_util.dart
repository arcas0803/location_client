import 'package:flutter/widgets.dart';
import 'package:location_client/localization/location_localizations.dart';
import 'package:location_client/src/location_failure.dart';

class LocationFailureUtil {
  static String getFailureNameUI({
    required BuildContext context,
    required LocationFailure failure,
  }) {
    switch (failure) {
      case LocationPermissionDeniedForeverFailure():
        return LocationLocalizations.of(context)!
            .locationPermissionDeniedForever;
      case LocationPermissionDeniedFailure():
        return LocationLocalizations.of(context)!.locationPermissionDenied;
      case LocationServiceDisabledFailure():
        return LocationLocalizations.of(context)!.locationServiceDisable;

      case LocationServiceRequestTimedOutFailure():
        return LocationLocalizations.of(context)!.locationTimeout;
      case LocationServiceUnknownFailure():
        return LocationLocalizations.of(context)!.locationUnknownError;
      case LocationAddressNotFoundFailure():
        return LocationLocalizations.of(context)!.addressNotFound;
      case LocationFromAddressNotFoundFailure():
        return LocationLocalizations.of(context)!.locationNotFound;
    }
  }
}
