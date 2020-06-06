import 'package:flutter/material.dart';
import 'package:weather_app/models/current.dart';
import 'package:weather_app/models/hourly.dart';
import 'package:weather_app/utils.dart';
import 'package:weather_app/widgets/chart_widget.dart';
import 'package:weather_app/widgets/general_weather_info_widget.dart';

class DetailsWeatherScreen extends StatelessWidget {
  final Current detailsWeather;
  final List<Hourly> hourlyForecast;

  const DetailsWeatherScreen(this.detailsWeather, this.hourlyForecast);

  @override
  Widget build(BuildContext context) {
    var imageUrl = detailsWeather.weather[0].icon;
    var now = DateTime.now();
    var dateTime =
        new DateTime.fromMillisecondsSinceEpoch(detailsWeather.dt * 1000);
    var parsedDay = convertToDaysPL(dateTime.weekday);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Szczegóły pogody",
        ),
        backgroundColor: Color.fromARGB(255, 255, 186, 163),
      ),
      body: Container(
        padding: EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          children: <Widget>[
            GeneralWeatherInfoWidget(
              detailsWeather: detailsWeather,
              imageUrl: imageUrl,
              now: now,
              parsedDay: parsedDay,
              dateTime: dateTime,
            ),
            SizedBox(
              height: 15.0,
            ),
            Divider(color: Colors.black12),
            SizedBox(
              height: 15.0,
            ),
            Row(
              children: <Widget>[
                Text(
                  'Wykres godzinny',
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.7),
                    fontSize: 18.0,
                  ),
                ),
                SizedBox(
                  width: 20.0,
                ),
                Row(
                  children: <Widget>[
                    CircleAvatar(
                      radius: 6.0,
                      backgroundColor: Colors.deepOrange,
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Text(
                      'Dzisiaj',
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: 20.0,
                ),
                Row(
                  children: <Widget>[
                    CircleAvatar(
                      radius: 6.0,
                      backgroundColor: Colors.deepPurple,
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Text(
                      'Jutro',
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            ConstrainedBox(
              constraints: BoxConstraints.expand(height: 200.0),
              child: StackedAreaLineChart(hourlyForecast),
            ),
          ],
        ),
      ),
    );
  }
}
