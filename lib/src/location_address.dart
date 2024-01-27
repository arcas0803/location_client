class LocationAddress {
  final String street;
  final String city;
  final String state;
  final String country;
  final String postalCode;

  LocationAddress({
    required this.street,
    required this.city,
    required this.state,
    required this.country,
    required this.postalCode,
  });

  LocationAddress copyWith({
    String? street,
    String? city,
    String? state,
    String? country,
    String? postalCode,
  }) {
    return LocationAddress(
      street: street ?? this.street,
      city: city ?? this.city,
      state: state ?? this.state,
      country: country ?? this.country,
      postalCode: postalCode ?? this.postalCode,
    );
  }

  @override
  String toString() {
    return 'LocationAddress(street: $street, city: $city, state: $state, country: $country, postalCode: $postalCode)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LocationAddress &&
        other.street == street &&
        other.city == city &&
        other.state == state &&
        other.country == country &&
        other.postalCode == postalCode;
  }

  @override
  int get hashCode {
    return street.hashCode ^
        city.hashCode ^
        state.hashCode ^
        country.hashCode ^
        postalCode.hashCode;
  }

  String get fullAddress => '$street, $city, $state, $country, $postalCode';
}
