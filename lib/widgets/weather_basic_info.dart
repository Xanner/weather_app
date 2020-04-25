import 'package:flutter/material.dart';
import 'package:weather_app/models/forecast.dart';

class WeatherBasicInfo extends StatelessWidget {
  final Forecast currentForecast;

  WeatherBasicInfo(this.currentForecast);
  @override
  Widget build(BuildContext context) {
    print(currentForecast);
    return Container(
      child: Text('currentForecast.temperature'),
    );
  }
}
