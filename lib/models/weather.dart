class Weather {
  final int timestamp;
  final double temperature;
  final double windSpeed;
  final String icon;

  factory Weather.fromJson(Map<String, dynamic> json) {
    final int timestamp = json['dt'];
    // kalvin to celsius
    final double temperature = (json['main']['temp'] - 273.15).toDouble();
    // m/s to km/h
    final double windSpeed = (json['wind']['speed'] * 3.6).toDouble();
    final String icon = json['weather'][0]['icon'];

    return Weather(
        timestamp: timestamp,
        temperature: temperature,
        windSpeed: windSpeed,
        icon: icon);
  }

  Weather({
    required this.timestamp,
    required this.temperature,
    required this.windSpeed,
    required this.icon,
  });
}
