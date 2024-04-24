import 'package:latlong2/latlong.dart';

class Address {
  final String city;
  final LatLng latLng;

  factory Address.fromGeoJson(
    Map<String, dynamic> json,
  ) {
    final Map<String, dynamic> properties = json['properties'] ?? {};
    final String city = properties['city'];
    final List<dynamic> coordinates = json['geometry']['coordinates'];
    return Address(city: city, latLng: LatLng(coordinates[1], coordinates[0]));
  }

  toJson() {
    return {
      'city': city,
      'lat': latLng.latitude,
      'lng': latLng.longitude,
    };
  }

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
        city: json['city'], latLng: LatLng(json['lat'], json['lng']));
  }

  Address({
    required this.city,
    required this.latLng,
  });
}
