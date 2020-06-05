import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:weather_app/models/hourly.dart';

class HourlyForecastList extends StatelessWidget {
  final List<Hourly> hourlyForecast;
  final bool isCurrent;

  HourlyForecastList(this.hourlyForecast, this.isCurrent);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    const mediumDeviceHeight = 640.0;

    var now = new DateTime.now();

    return Container(
      padding: EdgeInsets.only(
          top: mediaQuery.size.height <= mediumDeviceHeight ? 0 : 20),
      height: mediaQuery.size.height <= mediumDeviceHeight ? 104 : 120,
      child: ListView.builder(
        itemCount: hourlyForecast.length,
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
                (index == 0 && isCurrent) ? "Teraz" : "$parsedHour:00",
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
