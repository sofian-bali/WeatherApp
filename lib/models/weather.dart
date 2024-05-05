class Weather {
  final int timestamp;
  final int humidity;
  final double precipitation;
  final double temperature;
  final double windSpeed;
  final String icon;

  factory Weather.fromJson(Map<String, dynamic> json) {
    final int timestamp = json['dt'];
    final int humidity = json['main']['humidity']; // %
    final double precipitation =
        (json['pop']?.toDouble() ?? 0.0) * 100; // 0-1 to 0-100
    final double temperature =
        (json['main']['temp'] - 273.15).roundToDouble(); // kalvin to celsius
    final double windSpeed =
        (json['wind']['speed'] * 3.6).roundToDouble(); // m/s to km/h
    final String icon = json['weather'][0]['icon'];

    return Weather(
        timestamp: timestamp,
        humidity: humidity,
        precipitation: precipitation,
        temperature: temperature,
        windSpeed: windSpeed,
        icon: 'https://openweathermap.org/img/wn/$icon@2x.png');
  }

  Weather({
    required this.timestamp,
    required this.humidity,
    required this.precipitation,
    required this.temperature,
    required this.windSpeed,
    required this.icon,
  });
}
