import 'package:flutter/material.dart';
import '../screens/current_weather_screen.dart';
import '../screens/future_forecast_screen.dart';
import '../screens/tomorrow_weather_screen.dart';
import './current_location.dart';

class ForecastTabs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search), onPressed: () {}),
        ],
        bottom: TabBar(
          indicatorColor: Colors.white,
          tabs: [
            Tab(
              text: CurrentWeatherScreen.tabTitle,
            ),
            Tab(
              text: TomorrowWeatherScreen.tabTitle,
            ),
            Tab(
              text: FutureForecastScreen.tabTitle,
            ),
          ],
        ),
        title: CurrentLocation(),
      ),
      body: TabBarView(
        children: [
          CurrentWeatherScreen(),
          TomorrowWeatherScreen(),
          FutureForecastScreen()
        ],
      ),
    );
  }
}
