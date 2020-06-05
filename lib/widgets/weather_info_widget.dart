import 'dart:math';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:weather_app/screens/weather_details_screen.dart';
import 'package:weather_app/widgets/hourly_forecast_list.dart';
import 'package:weather_app/models/hourly.dart';
import 'package:weather_app/widgets/weather_card_widget.dart';

class WeatherInfoWidget extends StatelessWidget {
  const WeatherInfoWidget({
    Key key,
    @required this.temperature,
    @required this.imageUrl,
    @required this.description,
    @required this.windSpeed,
    @required this.dailyRainAmount,
    @required this.humidity,
    @required this.hourlyForecast,
    @required this.isCurrent,
  }) : super(key: key);

  final String temperature;
  final String imageUrl;
  final String description;
  final int windSpeed;
  final double dailyRainAmount;
  final int humidity;
  final List<Hourly> hourlyForecast;
  final bool isCurrent;

  @override
  Widget build(BuildContext context) {
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
                  temperature + "°C",
                  style: TextStyle(fontSize: 70.0),
                ),
                CachedNetworkImage(
                  imageUrl: 'http://openweathermap.org/img/wn/$imageUrl.png',
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
                Text(
                  description,
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
                    isCurrent
                        ? Center(
                            child: Transform.rotate(
                                angle: -90 * pi / 180,
                                child: IconButton(
                                  icon: Icon(
                                    Icons.arrow_back_ios,
                                    color: Color.fromARGB(255, 241, 156, 130),
                                    size: 32,
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              WeatherDetailsScreen()),
                                    );
                                  },
                                )),
                          )
                        : Center(),
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
                          WeatherCardWidget(
                            weatherIconUrl: 'assets/icons/wind.png',
                            weatherText: 'Wiatr $windSpeed m/s',
                          ),
                          WeatherCardWidget(
                            weatherIconUrl: 'assets/icons/rainy.png',
                            weatherText:
                                'Opady ${dailyRainAmount != null ? dailyRainAmount : 0.00} mm',
                          ),
                          WeatherCardWidget(
                            weatherIconUrl: 'assets/icons/humidity.png',
                            weatherText: 'Wilgotność $humidity%',
                          ),
                        ],
                      ),
                      HourlyForecastList(hourlyForecast, isCurrent),
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
