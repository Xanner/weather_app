import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/models/daily.dart';
import 'package:weather_app/utils.dart';

class FutureForecastScreen extends StatelessWidget {
  static const tabTitle = '7 dni';
  final List<Daily> dailyForecast;

  FutureForecastScreen(this.dailyForecast);

  String _capitalize(String s) => s[0].toUpperCase() + s.substring(1);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(8),
      itemCount: dailyForecast.length,
      itemBuilder: (BuildContext context, int index) {
        var forecast = dailyForecast[index].weather[0];
        var forecastIcon = dailyForecast[index].weather[0].icon;
        var dateTime = new DateTime.fromMillisecondsSinceEpoch(
            dailyForecast[index].dt * 1000);
        var parsedDay =
            index == 0 ? "Dzisiaj" : convertToDaysPL(dateTime.weekday);
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  parsedDay +
                      ', ' +
                      convertToMonthsPL(dateTime.month) +
                      ' ' +
                      dateTime.day.toString(),
                  style: TextStyle(fontSize: 18.0),
                ),
                SizedBox(height: 8),
                Text(
                  _capitalize(forecast.description),
                )
              ],
            ),
            Row(
              children: <Widget>[
                CachedNetworkImage(
                  imageUrl:
                      'http://openweathermap.org/img/wn/$forecastIcon.png',
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      dailyForecast[index].temp.day.round().toString() + '°C',
                      style: TextStyle(fontSize: 22.0),
                    ),
                    Text(
                      dailyForecast[index].feelsLike.day.round().toString() +
                          '°C',
                    ),
                  ],
                ),
              ],
            ),
          ],
        );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(
        color: Colors.white,
      ),
    );
  }
}
