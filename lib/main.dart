import 'package:flutter/material.dart';

import './screens/current_weather_screen.dart';
import './screens/tomorrow_weather_screen.dart';
import './screens/future_forecast_screen.dart';
import './widgets/current_location.dart';

void main() => runApp(RankineApp());

class RankineApp extends StatefulWidget {
  @override
  _RankineAppState createState() => _RankineAppState();
}

class _RankineAppState extends State<RankineApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rankine',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.transparent,
        brightness: Brightness.dark,
      ),
      home: DefaultTabController(
        length: 3,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                const Color.fromARGB(255, 255, 186, 163),
                const Color.fromARGB(255, 238, 204, 168)
              ],
            ),
          ),
          child: Scaffold(
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
          ),
        ),
      ),
    );
  }
}
