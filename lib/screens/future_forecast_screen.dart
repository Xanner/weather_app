import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../models/daily.dart';

class FutureForecastScreen extends StatelessWidget {
  static const tabTitle = '7 dni';
  final List<Daily> dailyForecast;

  FutureForecastScreen(this.dailyForecast);

  String _convertToDaysPL(int dayIndex) {
    if (dayIndex == 1) return "Poniedziałek";
    if (dayIndex == 2) return "Wtorek";
    if (dayIndex == 3) return "Środa";
    if (dayIndex == 4) return "Czwartek";
    if (dayIndex == 5) return "Piątek";
    if (dayIndex == 6) return "Sobota";
    if (dayIndex == 7) return "Niedziela";
  }

  String _convertToMonthsPL(int monthIndex) {
    if (monthIndex == 1) return "Styczeń";
    if (monthIndex == 2) return "Luty";
    if (monthIndex == 3) return "Marzec";
    if (monthIndex == 4) return "Kwiecień";
    if (monthIndex == 5) return "Maj";
    if (monthIndex == 6) return "Czerwiec";
    if (monthIndex == 7) return "Lipiec";
    if (monthIndex == 8) return "Sierpień";
    if (monthIndex == 9) return "Wrzesień";
    if (monthIndex == 10) return "Październik";
    if (monthIndex == 11) return "Listopad";
    if (monthIndex == 12) return "Grudzień";
  }

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
            index == 0 ? "Dzisiaj" : _convertToDaysPL(dateTime.weekday);
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  parsedDay +
                      ', ' +
                      _convertToMonthsPL(dateTime.month) +
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
                  children: <Widget>[
                    Text(
                      dailyForecast[index].temp.day.round().toString() + ' °C',
                      style: TextStyle(fontSize: 22.0),
                    ),
                    Text(
                      dailyForecast[index].feelsLike.day.round().toString() +
                          ' °C',
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
