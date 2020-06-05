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
      Current currentWeather = snapshot.data.current;
      double currentRainAmount = snapshot.data.daily[0].rain;
      List<Hourly> currentHourlyWeather =
          snapshot.data.hourly; // od teraz do 6 rano TODO

      Daily tomorrowWeather = snapshot.data.daily[1];
      double tomorrowRainAmount = snapshot.data.daily[1].rain;
      List<Hourly> tomorrowHourlyWeather =
          snapshot.data.hourly; //od 6 rano do 6 rano TODO

      List<Daily> dailyWeather = snapshot.data.daily;

      return <Widget>[
        Container(
          height: mediaQuery.size.height -
              appBarSize.preferredSize.height -
              mediaQuery.padding.top -
              24,
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
        const Padding(
          padding: EdgeInsets.only(top: 16),
          child: Center(
            child: Text(
              'Coś poszło nie tak, upewnij się, że masz włączony internet.', //TODO wyglada jak ...
            ),
          ),
        )
      ];
    }

    return FutureBuilder(
        future: forecast,
        builder: (context, snapshot) {
          List<Widget> children;
          if (snapshot.connectionState != ConnectionState.done) {
            children = _buildLoader();
          }
          if (snapshot.hasError) {
            children = _buildError();
          }
          if (snapshot.hasData) {
            children = _buildDataView(snapshot);
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
