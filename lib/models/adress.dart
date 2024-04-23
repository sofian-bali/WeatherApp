import 'package:latlong2/latlong.dart';

class Adress {
  final String city;
  final LatLng latLng;

  factory Adress.fromGeoJson(
    Map<String, dynamic> json,
  ) {
    final Map<String, dynamic> properties = json['properties'] ?? {};
    final String city = properties['city'];
    final List<dynamic> coordinates = json['geometry']['coordinates'];
    return Adress(city: city, latLng: LatLng(coordinates[1], coordinates[0]));
  }

  toJson() {
    return {
      'city': city,
      'lat': latLng.latitude,
      'lng': latLng.longitude,
    };
  }

  factory Adress.fromJson(Map<String, dynamic> json) {
    return Adress(city: json['city'], latLng: LatLng(json['lat'], json['lng']));
  }

  Adress({
    required this.city,
    required this.latLng,
  });
}
