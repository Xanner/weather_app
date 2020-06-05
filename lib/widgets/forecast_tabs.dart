import 'package:android_intent/android_intent.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../models/forecast.dart';
import '../screens/current_weather_screen.dart';
import '../screens/future_forecast_screen.dart';
import '../screens/tomorrow_weather_screen.dart';

import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

class ForecastTabs extends StatefulWidget {
  const ForecastTabs({
    Key key,

    /// If set, enable the FusedLocationProvider on Android
    @required this.androidFusedLocation,
  }) : super(key: key);

  final bool androidFusedLocation;
  @override
  _ForecastTabsState createState() => _ForecastTabsState();
}

class _ForecastTabsState extends State<ForecastTabs> {
  Position _currentPosition;
  //String _currentAddress;

  @override
  void initState() {
    super.initState();

    _initCurrentLocation();
  }

  @override
  void didUpdateWidget(Widget oldWidget) {
    super.didUpdateWidget(oldWidget);

    setState(() {
      _currentPosition = null;
    });

    _initCurrentLocation();
  }

  _initCurrentLocation() {
    Geolocator()
      ..forceAndroidLocationManager = !widget.androidFusedLocation
      ..getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
      ).then((position) {
        if (mounted) {
          setState(() => _currentPosition = position);
        }
      }).catchError((e) {
        print(e);
      });
  }

  Future<Forecast> fetchAndSetForecast() async {
    final urlBase = 'https://api.openweathermap.org/data/2.5/onecall';
    final apiKey = 'c5eda51f6f9a2bb874fbc57887b1d862';
    final lang = 'pl';
    final units = 'metric';
    final lat = _currentPosition.latitude;
    final lon = _currentPosition.longitude;

    final url =
        '$urlBase?lat=$lat&lon=$lon&units=$units&lang=$lang&appid=$apiKey';

    final response = await http.get(url);

    if (response.statusCode == 200) {
      return Forecast.fromJson(json.decode(response.body));
    } else {
      throw Exception('Nie udało się pobrać danych.');
    }
  }

  void openLocationSetting() async {
    final AndroidIntent intent = new AndroidIntent(
      action: 'android.settings.LOCATION_SOURCE_SETTINGS',
    );
    await intent.launch();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    final PreferredSizeWidget appBar = AppBar(
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      bottom: TabBar(
        indicatorColor: Colors.white,
        tabs: [
          Tab(
            text: CurrentWeatherScreen.tabTitle,
          ),
          Tab(
            text: TomorrowWeatherScreen.tabTitle,
          ),
          Tab(
            text: FutureForecastScreen.tabTitle,
          ),
        ],
      ),
      title: Text('MIASTO'),
      centerTitle: true,
      leading: IconButton(
          icon: Icon(Icons.my_location),
          onPressed: () {
            openLocationSetting();
            _initCurrentLocation();
          }),
    );

    List<Widget> _buildDataView(AsyncSnapshot<dynamic> snapshot) {
      return <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 16),
          child: Container(
            height: mediaQuery.size.height -
                appBar.preferredSize.height -
                mediaQuery.padding.top -
                16,
            child: TabBarView(
              children: [
                CurrentWeatherScreen(snapshot.data.current,
                    snapshot.data.daily[0].rain, snapshot.data.hourly),
                TomorrowWeatherScreen(snapshot.data.daily[1],
                    snapshot.data.daily[0].rain, snapshot.data.hourly),
                FutureForecastScreen(snapshot.data.daily)
              ],
            ),
          ),
        )
      ];
    }

    List<Widget> _buildLoader() {
      return <Widget>[
        SizedBox(
          child: CircularProgressIndicator(),
          width: 60,
          height: 60,
        ),
        const Padding(
          padding: EdgeInsets.only(top: 16),
          child: Text('Pobieranie danych...'),
        )
      ];
    }

    Widget WidgetBuilder(GeolocationStatus status) {
      if (status == GeolocationStatus.denied) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text('Wybierz lokalizację aby wyświetlić pogodę'),
          ],
        );
      }

      return FutureBuilder(
          future: fetchAndSetForecast(),
          builder: (context, snapshot) {
            List<Widget> children;
            if (snapshot.connectionState != ConnectionState.done) {
              children = _buildLoader();
            }
            if (snapshot.hasError) {
              print('jakis error');
              children = _buildLoader();
            }
            if (snapshot.hasData) {
              children = _buildDataView(snapshot);
            }
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: children,
              ),
            );
          });
    }

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
            body: WidgetBuilder(snapshot.data),
          );
        });
  }
}
