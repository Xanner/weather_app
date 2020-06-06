import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/models/current.dart';
import 'package:weather_app/utils.dart';

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
                  DateFormat('hh:mm').format(now),
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
