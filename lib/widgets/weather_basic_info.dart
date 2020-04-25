import 'package:flutter/material.dart';
import 'package:weather_app/screens/current_weather_screen.dart';

class WeatherBasicInfo extends StatelessWidget {
  final DailyForecast currentForecast;

  WeatherBasicInfo(this.currentForecast);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(currentForecast.cityName),
    );
  }
}
