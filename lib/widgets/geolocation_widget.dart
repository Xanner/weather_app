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

  Widget keyboardDismisser({BuildContext context, Widget child}) {
    final gesture = GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: child,
    );
    return gesture;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<GeolocationStatus>(
        future: Geolocator().checkGeolocationPermissionStatus(),
        builder:
            (BuildContext context, AsyncSnapshot<GeolocationStatus> snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          return this.keyboardDismisser(
              context: context,
              child: Scaffold(
                resizeToAvoidBottomInset: false,
                appBar: appBar,
                body: snapshot.data == GeolocationStatus.denied
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Wybierz lokalizację aby wyświetlić pogodę',
                          ),
                        ],
                      )
                    : ForecastWidget(forecast: forecast, appBarSize: appBar),
              ));
        });
  }
}
