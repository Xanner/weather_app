import 'package:flutter/material.dart';
import '../models/daily.dart';

class FutureForecastScreen extends StatelessWidget {
  static const tabTitle = '10 dni';
  final List<Daily> dailyForecast;

  FutureForecastScreen(this.dailyForecast);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('tu lista'), //TODO do zaimplementowania Lista Daily
    );
  }
}
