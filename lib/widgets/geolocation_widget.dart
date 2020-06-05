import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/models/forecast.dart';
import 'package:weather_app/widgets/forecast_widget.dart';

class GeolocationWidget extends StatelessWidget {
  const GeolocationWidget({
    Key key,
    @required this.appBar,
    @required this.forecast,
  }) : super(key: key);

  final PreferredSizeWidget appBar;
  final Future<Forecast> forecast;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<GeolocationStatus>(
        future: Geolocator().checkGeolocationPermissionStatus(),
        builder:
            (BuildContext context, AsyncSnapshot<GeolocationStatus> snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          return Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: appBar,
            body: snapshot.data == GeolocationStatus.denied
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Wybierz lokalizację aby wyświetlić pogodę',
                      ), //TODO sprawdzic jak to wyglada
                    ],
                  )
                : ForecastWidget(forecast: forecast, appBarSize: appBar),
          );
        });
  }
}
