import 'package:flutter/material.dart';
import '../models/hourly.dart';

class HourlyForecastList extends StatelessWidget {
  final List<Hourly> hourlyForecast;

  HourlyForecastList(this.hourlyForecast);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20),
      height: 110.0,
      child: ListView.builder(
        itemCount: hourlyForecast.length - 24,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          final imageUrl = hourlyForecast[index].weather[0].icon;
          var parsedHour = new DateTime.fromMillisecondsSinceEpoch(
                  hourlyForecast[index].dt * 1000)
              .hour;
          return Column(
            children: <Widget>[
              Text(
                index == 0 ? "Teraz" : "$parsedHour:00",
                style: TextStyle(color: Colors.black.withOpacity(0.5)),
              ),
              Image.network(
                'http://openweathermap.org/img/wn/$imageUrl.png',
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
