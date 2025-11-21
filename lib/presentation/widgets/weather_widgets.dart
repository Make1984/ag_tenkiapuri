import 'package:flutter/material.dart';
import '../../data/weather_model.dart';
import '../theme/app_theme.dart';

class HourlyForecastCard extends StatelessWidget {
  final Forecast forecast;

  const HourlyForecastCard({super.key, required this.forecast});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        gradient: AppTheme.cardGradient,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            forecast.time,
            style: const TextStyle(color: Colors.white, fontSize: 12),
          ),
          const SizedBox(height: 8),
          // Icon placeholder (using text for now, could be SVG or Icon)
          Icon(
            _getIconForCondition(forecast.condition),
            color: Colors.white,
            size: 24,
          ),
          const SizedBox(height: 8),
          Text(
            '${forecast.temperature}°',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      ),
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
}

class WeeklyForecastRow extends StatelessWidget {
  final Forecast forecast;

  const WeeklyForecastRow({super.key, required this.forecast});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 50,
            child: Text(
              forecast.time,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          Row(
            children: [
              Icon(
                _getIconForCondition(forecast.condition),
                color: Colors.white,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                forecast.condition,
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
          Text(
            '${forecast.temperature}°',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ],
      ),
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
}
