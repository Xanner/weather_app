import 'package:flutter/material.dart';
import 'package:weather_app/models/current.dart';
import 'package:weather_app/models/hourly.dart';
import 'package:weather_app/widgets/weather_info_widget.dart';

class CurrentWeatherScreen extends StatelessWidget {
  static const tabTitle = 'Dzisiaj';
  final Current currentForecast;
  final double currentDailyRain;
  final List<Hourly> currentHourlyForecast;

  CurrentWeatherScreen(
      this.currentForecast, this.currentDailyRain, this.currentHourlyForecast);

  @override
  Widget build(BuildContext context) {
    final currentTemp = currentForecast.temp.round().toString();
    final currentDescription = currentForecast.weather[0].description;
    final imageUrl = currentForecast.weather[0].icon;
    final currentWind = currentForecast.windSpeed.round();
    final currentHumidity = currentForecast.humidity;

    return WeatherInfoWidget(
      temperature: currentTemp,
      description: currentDescription,
      imageUrl: imageUrl,
      windSpeed: currentWind,
      dailyRainAmount: currentDailyRain,
      humidity: currentHumidity,
      hourlyForecast: currentHourlyForecast,
      isCurrent: true,
    );
  }
}
