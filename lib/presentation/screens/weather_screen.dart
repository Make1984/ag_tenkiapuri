import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import '../../data/weather_model.dart';
import '../../data/weather_repository.dart';
import '../theme/app_theme.dart';
import '../widgets/weather_widgets.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final WeatherRepository _repository = MockWeatherRepository();
  late Future<Weather> _weatherFuture;

  @override
  void initState() {
    super.initState();
    _weatherFuture = _repository.getWeather('Ogaki');
  }

  Future<void> _refreshWeather() async {
    setState(() {
      _weatherFuture = _repository.getWeather('Ogaki');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppTheme.backgroundGradient,
        ), // Default background
        child: SafeArea(
          child: FutureBuilder<Weather>(
            future: _weatherFuture,
            builder: (context, snapshot) {
              // We need to handle the background inside the builder to access data
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData) {
                return const Center(child: Text('No data'));
              }

              final weather = snapshot.data!;

              // Re-build the container with the correct image
              return Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(_getBackgroundImage(weather.condition)),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.4), // Darken for readability
                      BlendMode.darken,
                    ),
                  ),
                ),
                child: ScrollConfiguration(
                  behavior: ScrollConfiguration.of(context).copyWith(
                    dragDevices: {
                      PointerDeviceKind.touch,
                      PointerDeviceKind.mouse,
                    },
                  ),
                  child: RefreshIndicator(
                    onRefresh: _refreshWeather,
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20),
                          Text(
                            weather.city,
                            style: Theme.of(
                              context,
                            ).textTheme.headlineMedium?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Center(
                            child: Column(
                              children: [
                                Icon(
                                  _getIconForCondition(weather.condition),
                                  size: 64,
                                  color: Colors.white,
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  '${weather.temperature}°',
                                  style: const TextStyle(
                                    fontSize: 80,
                                    fontWeight: FontWeight.w200,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  weather.condition,
                                  style: const TextStyle(
                                    fontSize: 24,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  '最高:${weather.temperature + 2}° 最低:${weather.temperature - 3}°',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 40),
                          // Glassmorphic container for details
                          Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: Colors.white.withOpacity(0.2),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                _buildDetailItem('湿度', '${weather.humidity}%'),
                                _buildDetailItem(
                                  '風速',
                                  '${weather.windSpeed}m/s',
                                ),
                                _buildDetailItem(
                                  '体感',
                                  '${weather.temperature - 1}°',
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 30),
                          const Text(
                            '1時間ごとの予報',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 15),
                          SizedBox(
                            height: 120,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: weather.hourlyForecast.length,
                              itemBuilder: (context, index) {
                                return HourlyForecastCard(
                                  forecast: weather.hourlyForecast[index],
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 30),
                          const Text(
                            '週間予報',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 15),
                          ...weather.weeklyForecast.map(
                            (f) => WeeklyForecastRow(forecast: f),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildDetailItem(String label, String value) {
    return Column(
      children: [
        Text(label, style: const TextStyle(color: Colors.white)),
        const SizedBox(height: 5),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  IconData _getIconForCondition(String condition) {
    switch (condition) {
      case '晴れ':
        return Icons.wb_sunny;
      case 'くもり':
        return Icons.cloud;
      case '雨':
        return Icons.grain;
      default:
        return Icons.wb_sunny;
    }
  }

  String _getBackgroundImage(String condition) {
    switch (condition) {
      case '晴れ':
        return 'assets/images/sunny.png';
      case 'くもり':
        return 'assets/images/cloudy.png';
      case '雨':
        return 'assets/images/rainy.png';
      default:
        return 'assets/images/sunny.png';
    }
  }
}
