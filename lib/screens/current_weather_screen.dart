import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_app/widgets/weather_basic_info.dart';

class DailyForecast {
  final String cityName;

  DailyForecast({this.cityName});

  factory DailyForecast.fromJson(Map<String, dynamic> json) {
    return DailyForecast(
      cityName: json['name'],
    );
  }
}

class CurrentWeatherScreen extends StatelessWidget {
  static const tabTitle = 'Dzisiaj';

  Future<DailyForecast> fetchAndSetForecast() async {
    final location = 'Zywiec';
    final apiKey = 'c5eda51f6f9a2bb874fbc57887b1d862';
    final url =
        'https://api.openweathermap.org/data/2.5/weather?q=$location&units=metric&lang=pl&appid=$apiKey';
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return DailyForecast.fromJson(json.decode(response.body));
    } else {
      throw Exception('Nie udało się pobrać danych.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: fetchAndSetForecast(),
        builder: (BuildContext context, AsyncSnapshot<DailyForecast> snapshot) {
          List<Widget> children;

          if (snapshot.hasData) {
            print(snapshot.data);
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
