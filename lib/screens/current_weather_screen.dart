import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_app/models/forecast.dart';
import 'package:weather_app/widgets/weather_basic_info.dart';

class CurrentWeatherScreen extends StatelessWidget {
  static const tabTitle = 'Dzisiaj';

  Future<Forecast> fetchAndSetForecast() async {
    final apiKey = 'c5eda51f6f9a2bb874fbc57887b1d862';
    final lang = 'pl';
    final units = 'metric';
    final lat = 60.0;
    final lon = 30.9;

    final url =
        'https://api.openweathermap.org/data/2.5/onecall?lat=$lat&lon=$lon&units=$units&lang=$lang&appid=$apiKey';
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
      body: FutureBuilder(
        future: fetchAndSetForecast(),
        builder: (BuildContext context, AsyncSnapshot<Forecast> snapshot) {
          List<Widget> children;

          if (snapshot.hasData) {
            children = <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: WeatherBasicInfo(snapshot.data),
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
