class Weather {
  final String city;
  final int temperature;
  final String condition; // e.g., "Sunny", "Rainy"
  final int humidity;
  final int windSpeed;
  final List<Forecast> hourlyForecast;
  final List<Forecast> weeklyForecast;

  Weather({
    required this.city,
    required this.temperature,
    required this.condition,
    required this.humidity,
    required this.windSpeed,
    required this.hourlyForecast,
    required this.weeklyForecast,
  });
}

class Forecast {
  final String time; // e.g., "10:00" or "Monday"
  final int temperature;
  final String condition;

  Forecast({
    required this.time,
    required this.temperature,
    required this.condition,
  });
}
