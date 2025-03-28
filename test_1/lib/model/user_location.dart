import 'package:test_1/model/user_name.dart';

class UserLocation {
  final String city;
  final String state;
  final String country;
  final String postalCode;
  final LocationStreet street;
  final LocationsCoordinates coordinates;
  final LocationTimezoneCoordinates timezone;

  UserLocation({
    required this.city,
    required this.state,
    required this.country,
    required this.postalCode,
    required this.street,
    required this.coordinates,
    required this.timezone,
  });

  factory UserLocation.fromMap(Map<String, dynamic> json) {
    final coordinates = LocationsCoordinates.fromMap(json['coordinates']);
    final timezone = LocationTimezoneCoordinates.fromMap(json['timezone']);
    final street = LocationStreet.fromMap(json['street']);;
    return UserLocation(
      //street: json['street'],
      city: json['city'],
      state: json['state'],
      country: json['country'],
      postalCode: json['postcode'].toString(),
      coordinates: coordinates,
      timezone: timezone,
      street: street,
    );
  }
}

class LocationStreet {
  final int number;
  final String name;
  LocationStreet({required this.name, required this.number});

  factory LocationStreet.fromMap(Map<String, dynamic> json) {
return LocationStreet(
      name: json['name'],
      number: json['number'],
    );
  }
}

class LocationsCoordinates {
  final String latitude;
  final String longitude;

  LocationsCoordinates({
    required this.latitude,
    required this.longitude,
  });

  factory LocationsCoordinates.fromMap(Map<String, dynamic> json) {
    return LocationsCoordinates(
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
}}

class LocationTimezoneCoordinates {
  final String offset;
  final String description;

  LocationTimezoneCoordinates({
    required this.description,
    required this.offset,
  });


factory LocationTimezoneCoordinates.fromMap(Map<String, dynamic> json) {
  return LocationTimezoneCoordinates(
      description: json['description'],
      offset: json['offset'],
    );
  
}
}