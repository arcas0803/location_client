import 'location_localizations.dart';

/// The translations for English (`en`).
class LocationLocalizationsEn extends LocationLocalizations {
  LocationLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get locationPermissionDeniedForever => 'GEO Location permission denied forever. Please enable location permission from settings.';

  @override
  String get locationPermissionDenied => 'GEO Location permission denied. Please enable location permission from settings.';

  @override
  String get locationServiceDisable => 'Location service disabled. Please enable location service from settings.';

  @override
  String get locationTimeout => 'Location timeout. Please try again.';

  @override
  String get locationUnknownError => 'Unknown location error. Please try again.';

  @override
  String get addressNotFound => 'Address not found. Please try again.';

  @override
  String get locationNotFound => 'Location not found. Please try again.';
}
