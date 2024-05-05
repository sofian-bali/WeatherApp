import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/models/address.dart';
import 'package:weather_app/models/weather.dart';
import 'package:weather_app/repositories/weather_repository.dart';

class WeekState {
  final Map<String, Weather> week;

  WeekState({required this.week});
}

class WeekCubit extends Cubit<WeekState> {
  WeekCubit() : super(WeekState(week: {}));

  void setCurrentWeek(Address address) async {
    final weekWeather = await WeatherRepository().fetchWeather(address.latLng);
    final Map<String, List<Weather>> groupedDay = {};
    final Map<String, Weather> weatherDay = {};
    for (final weather in weekWeather) {
      final DateTime dateTime =
          DateTime.fromMillisecondsSinceEpoch(weather.timestamp * 1000);
      final String day =
          '${dateTime.day.toString().padLeft(2, '0')}/${dateTime.month.toString().padLeft(2, '0')}/${dateTime.year.toString()}';
      if (!groupedDay.containsKey(day)) {
        groupedDay[day] = [];
      }
      groupedDay[day]!.add(weather);
    }

    for (final day in groupedDay.keys) {
      final List<Weather> weathers = groupedDay[day]!;
      final int humidity = weathers
              .map((e) => e.humidity)
              .reduce((value, element) => value + element) ~/
          weathers.length;
      final double precipitation = weathers
              .map((e) => e.precipitation)
              .reduce((value, element) => value + element) /
          weathers.length;
      final double temperature = weathers
              .map((e) => e.temperature)
              .reduce((value, element) => value + element) /
          weathers.length;
      final double windSpeed = weathers
              .map((e) => e.windSpeed)
              .reduce((value, element) => value + element) /
          weathers.length;
      final String icon = weathers[0].icon;
      weatherDay[day] = Weather(
        timestamp: weathers[0].timestamp,
        humidity: humidity,
        precipitation: double.parse(precipitation.toStringAsFixed(1)),
        temperature: double.parse(temperature.toStringAsFixed(1)),
        windSpeed: double.parse(windSpeed.toStringAsFixed(1)),
        icon: icon,
      );
    }

    emit(WeekState(week: weatherDay));
  }
}
