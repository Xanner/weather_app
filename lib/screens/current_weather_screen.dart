import 'package:flutter/material.dart';
import '../models/current.dart';

class CurrentWeatherScreen extends StatelessWidget {
  static const tabTitle = 'Dzisiaj';
  final Current currentForecast;

  CurrentWeatherScreen(this.currentForecast);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(currentForecast.temp.toString()),
    );
  }
}
