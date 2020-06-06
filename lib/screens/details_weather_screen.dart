import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/models/current.dart';
import 'package:weather_app/models/hourly.dart';
import 'package:weather_app/utils.dart';
import 'package:weather_app/widgets/chart_widget.dart';
import 'package:weather_app/widgets/general_weather_info_widget.dart';

class DetailsWeatherScreen extends StatelessWidget {
  final Current detailsWeather;
  final double dailyRain;
  final List<Hourly> hourlyForecast;

  const DetailsWeatherScreen(
      this.detailsWeather, this.hourlyForecast, this.dailyRain);

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
          crossAxisAlignment: CrossAxisAlignment.start,
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
            SizedBox(
              height: 15.0,
            ),
            Divider(color: Colors.black12),
            Text(
              'Szczegóły',
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Colors.black.withOpacity(0.7),
                fontSize: 18.0,
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            FirstRow(detailsWeather: detailsWeather),
            SizedBox(
              height: 15.0,
            ),
            SecondRow(detailsWeather: detailsWeather, dailyRain: dailyRain),
            SizedBox(
              height: 15.0,
            ),
            ThirdRow(detailsWeather: detailsWeather),
          ],
        ),
      ),
    );
  }
}

class ThirdRow extends StatelessWidget {
  const ThirdRow({
    Key key,
    @required this.detailsWeather,
  }) : super(key: key);

  final Current detailsWeather;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Column(
          children: <Widget>[
            Text(
              'Widoczność',
              style: TextStyle(
                color: Colors.black.withOpacity(0.7),
              ),
            ),
            Text(
              (detailsWeather.visibility / 1000).toString() + ' km',
              style: TextStyle(
                color: Colors.black.withOpacity(0.7),
              ),
            ),
          ],
        ),
        Column(
          children: <Widget>[
            Text(
              'Indeks UV',
              style: TextStyle(
                color: Colors.black.withOpacity(0.7),
              ),
            ),
            Text(
              detailsWeather.uvi.toString(),
              style: TextStyle(
                color: Colors.black.withOpacity(0.7),
              ),
            ),
          ],
        ),
        Column(
          children: <Widget>[
            Text(
              'T odczuwalna',
              style: TextStyle(
                color: Colors.black.withOpacity(0.7),
              ),
            ),
            Text(
              detailsWeather.feelsLike.round().toString() + '°C',
              style: TextStyle(
                color: Colors.black.withOpacity(0.7),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class SecondRow extends StatelessWidget {
  const SecondRow({
    Key key,
    @required this.detailsWeather,
    @required this.dailyRain,
  }) : super(key: key);

  final Current detailsWeather;
  final double dailyRain;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Column(
          children: <Widget>[
            Text(
              'Zachód',
              style: TextStyle(
                color: Colors.black.withOpacity(0.7),
              ),
            ),
            Text(
              DateFormat('hh:mm').format(
                  new DateTime.fromMillisecondsSinceEpoch(
                      detailsWeather.sunset * 1000)),
              style: TextStyle(
                color: Colors.black.withOpacity(0.7),
              ),
            ),
          ],
        ),
        Column(
          children: <Widget>[
            Text(
              'Opady',
              style: TextStyle(
                color: Colors.black.withOpacity(0.7),
              ),
            ),
            Text(
              (dailyRain == null ? 0.00 : dailyRain).toString() + ' mm',
              style: TextStyle(
                color: Colors.black.withOpacity(0.7),
              ),
            ),
          ],
        ),
        Column(
          children: <Widget>[
            Text(
              'Ciśnienie',
              style: TextStyle(
                color: Colors.black.withOpacity(0.7),
              ),
            ),
            Text(
              detailsWeather.pressure.toString() + ' hPa',
              style: TextStyle(
                color: Colors.black.withOpacity(0.7),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class FirstRow extends StatelessWidget {
  const FirstRow({
    Key key,
    @required this.detailsWeather,
  }) : super(key: key);

  final Current detailsWeather;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Column(
          children: <Widget>[
            Text(
              'Wschód',
              style: TextStyle(
                color: Colors.black.withOpacity(0.7),
              ),
            ),
            Text(
              DateFormat('hh:mm').format(
                  new DateTime.fromMillisecondsSinceEpoch(
                      detailsWeather.sunrise * 1000)),
              style: TextStyle(
                color: Colors.black.withOpacity(0.7),
              ),
            ),
          ],
        ),
        Column(
          children: <Widget>[
            Text(
              'Wiatr',
              style: TextStyle(
                color: Colors.black.withOpacity(0.7),
              ),
            ),
            Text(
              detailsWeather.windSpeed.round().toString() + ' m/s',
              style: TextStyle(
                color: Colors.black.withOpacity(0.7),
              ),
            ),
          ],
        ),
        Column(
          children: <Widget>[
            Text(
              'Wilgotność',
              style: TextStyle(
                color: Colors.black.withOpacity(0.7),
              ),
            ),
            Text(
              detailsWeather.humidity.toString() + '%',
              style: TextStyle(
                color: Colors.black.withOpacity(0.7),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
