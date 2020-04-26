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
          child: Column(
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
        Expanded(
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
              ),
              Container(
                transform: Matrix4.translationValues(0.0, -50.0, 0.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                            child: Container(
                          padding: EdgeInsets.only(top: 15),
                          child: Column(
                            children: <Widget>[
                              Image(image: AssetImage('assets/icons/wind.png')),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text('Wiatr $currentWind m/s'),
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
                        )),
                        Expanded(
                            child: Container(
                          padding: EdgeInsets.only(top: 15),
                          child: Column(
                            children: <Widget>[
                              Image(
                                  image: AssetImage('assets/icons/rainy.png')),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text('Opady $currentDailyRain mm'),
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
                        )),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.only(top: 15),
                            child: Column(
                              children: <Widget>[
                                Image(
                                    image: AssetImage(
                                        'assets/icons/humidity.png')),
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Text('Wilgotność $currentHumidity%'),
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
                        ),
                      ],
                    ),
                    HourlyForecastList(currentHourlyForecast),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Center(
                        child: Transform.rotate(
                          angle: -90 * pi / 180,
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: Color.fromARGB(255, 241, 156, 130),
                            size: 32,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
