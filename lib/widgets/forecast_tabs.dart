import 'package:flutter/material.dart';
import '../models/forecast.dart';
import '../screens/current_weather_screen.dart';
import '../screens/future_forecast_screen.dart';
import '../screens/tomorrow_weather_screen.dart';
import './current_location.dart';

import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

class ForecastTabs extends StatelessWidget {
  Future<Forecast> fetchAndSetForecast() async {
    final urlBase = 'https://api.openweathermap.org/data/2.5/onecall';
    final apiKey = 'c5eda51f6f9a2bb874fbc57887b1d862';
    final lang = 'pl';
    final units = 'metric';
    final lat = 49.6913;
    final lon = 19.1824;

    final url =
        '$urlBase?lat=$lat&lon=$lon&units=$units&lang=$lang&appid=$apiKey';
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return Forecast.fromJson(json.decode(response.body));
    } else {
      throw Exception('Nie udało się pobrać danych.');
    }
  }

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
      body: FutureBuilder(
        future: fetchAndSetForecast(),
        builder: (BuildContext context, AsyncSnapshot<Forecast> snapshot) {
          List<Widget> children;

          if (snapshot.hasData) {
            children = <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Container(
                  height: 496,
                  child: TabBarView(
                    children: [
                      CurrentWeatherScreen(snapshot.data.current),
                      TomorrowWeatherScreen(snapshot.data.hourly),
                      FutureForecastScreen(snapshot.data.daily)
                    ],
                  ),
                ),
              )
            ];
          } else if (snapshot.hasError) {
            children = <Widget>[
              Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 60,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text('Error: ${snapshot.error}'),
              )
            ];
          } else {
            children = <Widget>[
              SizedBox(
                child: CircularProgressIndicator(),
                width: 60,
                height: 60,
              ),
              const Padding(
                padding: EdgeInsets.only(top: 16),
                child: Text('Pobieranie danych...'),
              )
            ];
          }
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: children,
            ),
          );
        },
      ),
    );
  }
}
