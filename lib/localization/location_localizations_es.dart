import 'location_localizations.dart';

/// The translations for Spanish Castilian (`es`).
class LocationLocalizationsEs extends LocationLocalizations {
  LocationLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get locationPermissionDeniedForever => 'Permiso de ubicación denegado para siempre. Por favor, vaya a la configuración de la aplicación y habilite el permiso de ubicación.';

  @override
  String get locationPermissionDenied => 'Permiso de ubicación denegado. Por favor, habilite el permiso de ubicación.';

  @override
  String get locationServiceDisable => 'Servicio de ubicación desactivado. Por favor, habilite el servicio de ubicación.';

  @override
  String get locationTimeout => 'Tiempo de espera de ubicación. Por favor, inténtelo de nuevo.';

  @override
  String get locationUnknownError => 'Error desconocido de ubicación. Por favor, inténtelo de nuevo.';

  @override
  String get addressNotFound => 'Dirección no encontrada. Compruebe que la dirección sea correcta.';

  @override
  String get locationNotFound => 'Ubicación no encontrada. Por favor, inténtelo de nuevo.';
}
