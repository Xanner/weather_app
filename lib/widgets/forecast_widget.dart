import 'dart:async';
import 'package:flutter/material.dart';
import 'package:weather_app/models/current.dart';
import 'package:weather_app/models/daily.dart';
import 'package:weather_app/models/forecast.dart';
import 'package:weather_app/models/hourly.dart';
import 'package:weather_app/screens/current_weather_screen.dart';
import 'package:weather_app/screens/future_forecast_screen.dart';
import 'package:weather_app/screens/tomorrow_weather_screen.dart';

class ForecastWidget extends StatelessWidget {
  final PreferredSizeWidget appBarSize;
  const ForecastWidget({
    Key key,
    @required this.forecast,
    @required this.appBarSize,
  }) : super(key: key);

  final Future<Forecast> forecast;

  @override
  Widget build(BuildContext context) {
    List<Widget> _buildDataView(AsyncSnapshot<Forecast> snapshot) {
      final mediaQuery = MediaQuery.of(context);
      Current currentWeather = snapshot.data?.current;
      double currentRainAmount = snapshot.data?.daily[0].rain;

      var now = new DateTime.now();
      var amountHours = (now.hour - 24).abs() + 7;
      if (now.hour <= 6) {
        amountHours = 24;
      } else {
        amountHours = 24 - now.hour + 7;
      }

      List<Hourly> currentHourlyWeather = snapshot.data.hourly;

      Daily tomorrowWeather = snapshot.data?.daily[1];
      double tomorrowRainAmount = snapshot.data?.daily[1].rain;
      List<Hourly> tomorrowHourlyWeather =
          snapshot.data.hourly.skip(amountHours).take(25).toList();

      List<Daily> dailyWeather = snapshot.data?.daily;

      var amountDiff = mediaQuery.size.height > 640 ? 32 : 24;
      return <Widget>[
        Container(
          height: mediaQuery.size.height -
              appBarSize.preferredSize.height -
              mediaQuery.padding.top -
              amountDiff,
          child: TabBarView(
            children: [
              CurrentWeatherScreen(
                currentWeather,
                currentRainAmount,
                currentHourlyWeather,
              ),
              TomorrowWeatherScreen(
                tomorrowWeather,
                tomorrowRainAmount,
                tomorrowHourlyWeather,
              ),
              FutureForecastScreen(
                dailyWeather,
              )
            ],
          ),
        ),
      ];
    }

    List<Widget> _buildLoader() {
      return <Widget>[
        SizedBox(
          child: CircularProgressIndicator(),
          width: 60,
          height: 60,
        ),
        const Padding(
          padding: EdgeInsets.only(top: 16),
          child: Text('Pobieranie w toku'),
        )
      ];
    }

    List<Widget> _buildError() {
      return <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 16),
          child: Center(
            child: Column(
              children: <Widget>[
                Image(
                  image: AssetImage('assets/whoops.png'),
                ),
                Text(
                  'Coś poszło nie tak, upewnij się, że masz włączony internet i spróbuj ponownie wyszukać miejsce.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18.0),
                ),
              ],
            ),
          ),
        )
      ];
    }

    return FutureBuilder(
        future: forecast,
        builder: (context, snapshot) {
          List<Widget> children;
          if (snapshot.connectionState == ConnectionState.waiting) {
            children = _buildLoader();
          }
          if (snapshot.hasError) {
            children = _buildError();
          }
          if (snapshot.connectionState == ConnectionState.done) {
            print(snapshot);
            children = snapshot.error != null
                ? _buildError()
                : _buildDataView(snapshot);
          }
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: children,
            ),
          );
        });
  }
}
