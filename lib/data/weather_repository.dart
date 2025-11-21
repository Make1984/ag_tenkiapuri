import 'weather_model.dart';

abstract class WeatherRepository {
  Future<Weather> getWeather(String city);
}

class MockWeatherRepository implements WeatherRepository {
  @override
  Future<Weather> getWeather(String city) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));

    if (city == 'Ogaki') {
      return Weather(
        city: '大垣市',
        temperature: 18,
        condition: 'くもり',
        humidity: 65,
        windSpeed: 3,
        hourlyForecast: [
          Forecast(time: '12:00', temperature: 18, condition: 'くもり'),
          Forecast(time: '13:00', temperature: 19, condition: 'くもり'),
          Forecast(time: '14:00', temperature: 20, condition: '晴れ'),
          Forecast(time: '15:00', temperature: 19, condition: '晴れ'),
          Forecast(time: '16:00', temperature: 17, condition: 'くもり'),
        ],
        weeklyForecast: [
          Forecast(time: '月', temperature: 18, condition: 'くもり'),
          Forecast(time: '火', temperature: 16, condition: '雨'),
          Forecast(time: '水', temperature: 15, condition: '雨'),
          Forecast(time: '木', temperature: 17, condition: 'くもり'),
          Forecast(time: '金', temperature: 19, condition: '晴れ'),
        ],
      );
    } else {
      // Default to Ogaki for now
      return getWeather('Ogaki');
    }
  }
}
