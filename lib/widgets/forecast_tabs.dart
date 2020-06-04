import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/widgets/autocomplete_search.dart';
import '../models/forecast.dart';
import '../screens/current_weather_screen.dart';
import '../screens/future_forecast_screen.dart';
import '../screens/tomorrow_weather_screen.dart';
import './current_location.dart';

import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

class ForecastTabs extends StatefulWidget {
  @override
  _ForecastTabsState createState() => _ForecastTabsState();
}

class _ForecastTabsState extends State<ForecastTabs> {
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

  Position _currentPosition;
  String _currentAddress;

  @override
  void initState() {
    _getCurrentLocation();
    super.initState();
  }

  Future<Forecast> fetchAndSetForecast() async {
    final urlBase = 'https://api.openweathermap.org/data/2.5/onecall';
    final apiKey = 'c5eda51f6f9a2bb874fbc57887b1d862';
    final lang = 'pl';
    final units = 'metric';
    final lat = _currentPosition?.latitude;
    final lon = _currentPosition?.longitude;

    final url =
        '$urlBase?lat=$lat&lon=$lon&units=$units&lang=$lang&appid=$apiKey';

    final response = await http.get(url);

    if (response.statusCode == 200) {
      return Forecast.fromJson(json.decode(response.body));
    } else {
      throw Exception('Nie udało się pobrać danych.');
    }
  }

  _getCurrentLocation() {
    final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
      });

      _getAddressFromLatLng();
    }).catchError((e) {
      print(e);
    });
  }

  _getAddressFromLatLng() async {
    try {
      List<Placemark> p = await geolocator.placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);

      Placemark place = p[0];

      setState(() {
        _currentAddress =
            "${place.subLocality}, ${place.subAdministrativeArea}";
      });
    } catch (e) {
      print(e);
    }
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
      title: AutoComplete(),
      centerTitle: true,
      leading: IconButton(
          icon: Icon(Icons.ac_unit),
          onPressed: () {
            _getCurrentLocation();
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

    final builder = FutureBuilder(
        future: fetchAndSetForecast(),
        builder: (context, snapshot) {
          List<Widget> children;
          if (snapshot.connectionState != ConnectionState.done) {
            children = _buildLoader();
          }
          if (snapshot.hasError) {
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

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: appBar,
      body: builder,
    );
  }
}
