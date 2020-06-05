import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/models/current.dart';
import 'package:weather_app/utils.dart';

class DetailsWeatherScreen extends StatelessWidget {
  final Current detailsWeather;

  const DetailsWeatherScreen(this.detailsWeather);

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
          "Tutaj aktualna lokalizacja",
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
            Row(
              children: <Widget>[
                Text(
                  'Wykres godzinny',
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.7),
                    fontSize: 18.0,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class GeneralWeatherInfoWidget extends StatelessWidget {
  const GeneralWeatherInfoWidget({
    Key key,
    @required this.detailsWeather,
    @required this.imageUrl,
    @required this.now,
    @required this.parsedDay,
    @required this.dateTime,
  }) : super(key: key);

  final Current detailsWeather;
  final String imageUrl;
  final DateTime now;
  final String parsedDay;
  final DateTime dateTime;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Tutaj aktualna lokalizacja',
          style: TextStyle(
            color: Colors.black.withOpacity(0.7),
            fontSize: 20.0,
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  detailsWeather.temp.round().toString() + '°C',
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.7),
                    fontSize: 18.0,
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  'T odczuwalna ' +
                      detailsWeather.feelsLike.round().toString() +
                      '°C',
                  style: TextStyle(color: Colors.black.withOpacity(0.7)),
                ),
              ],
            ),
            CachedNetworkImage(
              imageUrl: 'http://openweathermap.org/img/wn/$imageUrl.png',
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  now.hour.toString() + ':' + now.minute.toString(),
                  style: TextStyle(color: Colors.black.withOpacity(0.7)),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                    parsedDay +
                        ', ' +
                        dateTime.day.toString() +
                        ' ' +
                        convertToMonthsPL(dateTime.month),
                    style: TextStyle(color: Colors.black.withOpacity(0.7))),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
