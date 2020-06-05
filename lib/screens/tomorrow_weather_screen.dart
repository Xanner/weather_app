import 'package:flutter/material.dart';
import 'package:weather_app/models/daily.dart';
import 'package:weather_app/models/hourly.dart';
import 'package:weather_app/widgets/weather_info_widget.dart';

class TomorrowWeatherScreen extends StatelessWidget {
  static const tabTitle = 'Jutro';
  final Daily tomorrowWeather;
  final double tomorrowRainAmount;
  final List<Hourly> tomorrowHourlyWeather;

  TomorrowWeatherScreen(
    this.tomorrowWeather,
    this.tomorrowRainAmount,
    this.tomorrowHourlyWeather,
  );

  @override
  Widget build(BuildContext context) {
    final tomorrowTemp = tomorrowWeather.temp.day.round().toString();
    final tomorrowDescription = tomorrowWeather.weather[0].description;
    final tomorrowWind = tomorrowWeather.windSpeed.round();
    final tomorrowHumidity = tomorrowWeather.humidity;
    final imageUrl = tomorrowWeather.weather[0].icon;

    return WeatherInfoWidget(
      temperature: tomorrowTemp,
      description: tomorrowDescription,
      imageUrl: imageUrl,
      windSpeed: tomorrowWind,
      dailyRainAmount: tomorrowRainAmount,
      humidity: tomorrowHumidity,
      hourlyForecast: tomorrowHourlyWeather,
      isCurrent: false,
    );
  }
}
