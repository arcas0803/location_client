class LocationPosition {
  final double latitude;
  final double longitude;
  final DateTime timestamp;

  LocationPosition({
    required this.latitude,
    required this.longitude,
    required this.timestamp,
  });

  LocationPosition copyWith({
    double? latitude,
    double? longitude,
    DateTime? timestamp,
  }) {
    return LocationPosition(
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  @override
  String toString() =>
      'LocationPosition(latitude: $latitude, longitude: $longitude, timestamp: $timestamp)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LocationPosition &&
        other.latitude == latitude &&
        other.longitude == longitude &&
        other.timestamp == timestamp;
  }

  @override
  int get hashCode =>
      latitude.hashCode ^ longitude.hashCode ^ timestamp.hashCode;
}
