import '../utils/constants.dart';

class WeatherModel {
  final String cityName;
  final String country;
  final double temperature; // °C
  final double feelsLike; // °C
  final int humidity;
  final double windSpeed; // m/s
  final int visibility; // km
  final int pressure; // hPa
  final String condition; // e.g. Rain, Clouds, Clear
  final String description;

  WeatherModel({
    required this.cityName,
    required this.country,
    required this.temperature,
    required this.feelsLike,
    required this.humidity,
    required this.windSpeed,
    required this.visibility,
    required this.pressure,
    required this.condition,
    required this.description,
  });

  // The service calls the API without units=metric, so values arrive in Kelvin.
  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    final main = json['main'] as Map<String, dynamic>;
    final weatherList = json['weather'] as List<dynamic>;
    final w = weatherList.isNotEmpty
        ? weatherList[0] as Map<String, dynamic>
        : <String, dynamic>{};
    final wind = (json['wind'] as Map<String, dynamic>?) ?? {};
    final sys = (json['sys'] as Map<String, dynamic>?) ?? {};

    return WeatherModel(
      cityName: (json['name'] ?? 'Unknown') as String,
      country: (sys['country'] ?? '') as String,
      temperature: ((main['temp'] as num).toDouble()) - 273.15,
      feelsLike: ((main['feels_like'] as num).toDouble()) - 273.15,
      humidity: (main['humidity'] as num).toInt(),
      windSpeed: ((wind['speed'] ?? 0) as num).toDouble(),
      visibility: (((json['visibility'] ?? 10000) as num) / 1000).round(),
      pressure: (main['pressure'] as num).toInt(),
      condition: (w['main'] ?? 'Clear') as String,
      description: (w['description'] ?? '') as String,
    );
  }

  String get tempFormatted => '${temperature.round()}°C';
  String get feelsLikeFormatted => '${feelsLike.round()}°C';

  bool get isHeatwave => temperature >= AppConstants.heatwaveThreshold;
  bool get isCold => temperature <= AppConstants.coldThreshold;
  bool get isRainy {
    final c = condition.toLowerCase();
    return c.contains('rain') || c.contains('drizzle') || c.contains('thunder');
  }
}