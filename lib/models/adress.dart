import 'package:latlong2/latlong.dart';

class Adress {
  final String street;
  final String city;
  final LatLng latLng;

  factory Adress.fromGeoJson(Map<String, dynamic> json) {
    final Map<String, dynamic> properties = json['properties'] ?? {};
    final String street = properties['name'];
    final String city = properties['city'];
    final List<dynamic> coordinates = json['geometry']['coordinates'];
    return Adress(
        street: street,
        city: city,
        latLng: LatLng(coordinates[1], coordinates[0]));
  }

  toJson() {
    return {
      'street': street,
      'city': city,
      'lat': latLng.latitude,
      'lng': latLng.longitude,
    };
  }

  factory Adress.fromJson(Map<String, dynamic> json) {
    return Adress(
        street: json['street'],
        city: json['city'],
        latLng: LatLng(json['lat'], json['lng']));
  }

  Adress({required this.street, required this.city, required this.latLng});
}
