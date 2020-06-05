import 'package:flutter/material.dart';

class WeatherCardWidget extends StatelessWidget {
  const WeatherCardWidget({
    Key key,
    @required this.weatherIconUrl,
    @required this.weatherText,
  }) : super(key: key);

  final String weatherIconUrl;
  final String weatherText;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.only(top: 15),
        child: Column(
          children: <Widget>[
            Image(image: AssetImage(weatherIconUrl)),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: new Text(
                  weatherText,
                  maxLines: 1,
                ),
              ),
            ),
          ],
        ),
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
      ),
    );
  }
}
