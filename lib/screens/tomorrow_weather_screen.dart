import 'package:flutter/material.dart';
import '../models/hourly.dart';

class TomorrowWeatherScreen extends StatelessWidget {
  static const tabTitle = 'Jutro';
  final List<Hourly> hourlyForecast;

  TomorrowWeatherScreen(this.hourlyForecast);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('tu pogoda na jutro z detalami'),
    );
  }
}
