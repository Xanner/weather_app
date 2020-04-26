import 'package:flutter/material.dart';
import '../models/current.dart';

class CurrentWeatherScreen extends StatelessWidget {
  static const tabTitle = 'Dzisiaj';
  final Current currentForecast;

  CurrentWeatherScreen(this.currentForecast);

  @override
  Widget build(BuildContext context) {
    final imageUrl = currentForecast.weather[0].icon;
    print(currentForecast.weather[0].description);
    return Column(
      children: <Widget>[
        Expanded(
          child: Column(
            children: <Widget>[
              Text(
                currentForecast.temp.round().toString() + "°C",
                style: TextStyle(fontSize: 70.0),
              ),
              Image.network(
                'http://openweathermap.org/img/wn/$imageUrl.png',
              ),
              Text(
                currentForecast.weather[0].description,
                style: TextStyle(fontSize: 18.0),
              ),
            ],
          ),
        ),
        Expanded(
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
              ),
              Container(
                transform: Matrix4.translationValues(0.0, -50.0, 0.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: Container(
                      margin: EdgeInsets.all(7),
                      height: 80,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 241, 156, 130),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 4,
                            color: Colors.black38,
                            offset: Offset(0, 2),
                          )
                        ],
                      ),
                    )),
                    Expanded(
                        child: Container(
                      margin: EdgeInsets.all(7),
                      height: 80,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 241, 156, 130),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 4,
                            color: Colors.black38,
                            offset: Offset(0, 2),
                          )
                        ],
                      ),
                    )),
                    Expanded(
                        child: Container(
                      margin: EdgeInsets.all(7),
                      height: 80,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 241, 156, 130),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 4,
                            color: Colors.black38,
                            offset: Offset(0, 2),
                          )
                        ],
                      ),
                    )),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
