import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../models/hourly.dart';

class HourlyForecastList extends StatelessWidget {
  final List<Hourly> hourlyForecast;

  HourlyForecastList(this.hourlyForecast);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20),
      height: 120.0,
      child: ListView.builder(
        itemCount: hourlyForecast.length - 24,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          final imageUrl = hourlyForecast[index].weather[0].icon;
          var parsedHour = new DateTime.fromMillisecondsSinceEpoch(
                  hourlyForecast[index].dt * 1000)
              .hour;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                index == 0 ? "Teraz" : "$parsedHour:00",
                style: TextStyle(color: Colors.black.withOpacity(0.5)),
              ),
              CachedNetworkImage(
                imageUrl: 'http://openweathermap.org/img/wn/$imageUrl.png',
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
              Text(
                hourlyForecast[index].temp.round().toString() + "°C ",
                style: TextStyle(
                    color: Colors.black.withOpacity(0.5), fontSize: 18),
              ),
            ],
          );
        },
      ),
    );
  }
}
