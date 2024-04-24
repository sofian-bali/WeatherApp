import 'dart:convert';

import 'package:http/http.dart';
import 'package:latlong2/latlong.dart';
import 'package:weather_app/constante.dart';
import 'package:weather_app/models/weather.dart';

class WeatherRepository {
  WeatherRepository();

  Future<List<Weather>> fetchWeather(LatLng latLng) async {
    final Response response = await get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/forecast?lat=${latLng.latitude}&lon=${latLng.longitude}&appid=$apiWeatherKey'));
    if (response.statusCode == 200) {
      final List<Weather> weathers = [];
      final Map<String, dynamic> json = jsonDecode(response.body);
      if (json.containsKey("list")) {
        final List<dynamic> days = json['list'];
        for (Map<String, dynamic> day in days) {
          final Weather weather = Weather.fromJson(day);
          weathers.add(weather);
        }
      }
      return weathers;
    } else {
      return [];
    }
  }

  Future<Weather?> fetchCurrentWeather(LatLng latLng) async {
    final Response response = await get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=${latLng.latitude}&lon=${latLng.longitude}&appid=$apiWeatherKey'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> json = jsonDecode(response.body);
      return Weather.fromJson(json);
    } else {
      return null;
    }
  }
}
