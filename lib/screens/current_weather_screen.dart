import 'package:flutter/material.dart';
import 'package:weather_app/widgets/hourly_forecast_list.dart';
import '../models/hourly.dart';
import '../models/current.dart';
import 'dart:math';

class CurrentWeatherScreen extends StatelessWidget {
  static const tabTitle = 'Dzisiaj';
  final Current currentForecast;
  final double currentDailyRain;
  final List<Hourly> currentHourlyForecast;

  CurrentWeatherScreen(
      this.currentForecast, this.currentDailyRain, this.currentHourlyForecast);

  Widget WeatherCard(AssetImage weatherIcon, Text weatherText) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.only(top: 15),
        child: Column(
          children: <Widget>[
            Image(image: weatherIcon),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: weatherText,
            ),
          ],
        ),
        margin: EdgeInsets.all(7),
        height: 80,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 241, 156, 130),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          boxShadow: [
            BoxShadow(
              blurRadius: 4,
              color: Colors.black38,
              offset: Offset(0, 2),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentWind = currentForecast.windSpeed.round();
    final currentHumidity = currentForecast.humidity;
    final imageUrl = currentForecast.weather[0].icon;
    var date =
        new DateTime.fromMillisecondsSinceEpoch(currentForecast.dt * 1000);

    return Column(
      children: <Widget>[
        Expanded(
          flex: 6,
          child: Container(
            transform: Matrix4.translationValues(0.0, -40.0, 0.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  currentForecast.temp.round().toString() + "°C",
                  style: TextStyle(fontSize: 70.0),
                ),
                Image.network(
                  'http://openweathermap.org/img/wn/$imageUrl.png',
                ),
                Text(
                  currentForecast.weather[0].description,
                  style: TextStyle(fontSize: 18.0),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 4,
          child: Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Center(
                      child: Transform.rotate(
                        angle: -90 * pi / 180,
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: Color.fromARGB(255, 241, 156, 130),
                          size: 32,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                transform: Matrix4.translationValues(0.0, -50.0, 0.0),
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          WeatherCard(
                            AssetImage('assets/icons/wind.png'),
                            Text('Wiatr $currentWind m/s'),
                          ),
                          WeatherCard(
                            AssetImage('assets/icons/rainy.png'),
                            Text('Opady $currentDailyRain mm'),
                          ),
                          WeatherCard(
                            AssetImage('assets/icons/humidity.png'),
                            Text('Wilgotność $currentHumidity%'),
                          ),
                        ],
                      ),
                      HourlyForecastList(currentHourlyForecast),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
