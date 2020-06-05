import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart' hide LocationAccuracy;
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
    @required this.androidFusedLocation,
  }) : super(key: key);

  final bool androidFusedLocation;
  @override
  _ForecastTabsState createState() => _ForecastTabsState();
}

class _ForecastTabsState extends State<ForecastTabs> {
  Position _currentPosition;
  bool _isDialogOpen;
  final Geolocator _geolocator = Geolocator();
  final TextEditingController _addressTextController = TextEditingController();

  Future<Forecast> forecast;

  @override
  void initState() {
    super.initState();
    _initCurrentLocation();
    setState(() {
      _isDialogOpen = false;
      forecast = fetchAndSetForecast();
    });
  }

  void _initCurrentLocation() {
    openLocationSetting();
    Geolocator()
      ..forceAndroidLocationManager = !widget.androidFusedLocation
      ..getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
      ).then((position) {
        if (mounted) {
          setState(() {
            _currentPosition = position;
            forecast = fetchAndSetForecast();
            _addressTextController.text = 'XD';
          });
        }
      }).catchError((e) {
        print(e);
      });
  }

  Future<void> _showMyDialog(String title, String info) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(info),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<Forecast> fetchAndSetForecast() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
      }
    } on SocketException catch (_) {
      print('not connected');
      if (_isDialogOpen == false) {
        _showMyDialog('Brak połaczenia z internetem',
            'Aby wyszukać aktualną pogodę podłącz się do sieci i kliknij OK.');
        setState(() {
          _isDialogOpen = true;
        });
      }
    }
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

  void openLocationSetting() async {
    Location location = new Location();

    bool _serviceEnabled;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }
  }

  Future<void> _onLookupCoordinatesPressed() async {
    final List<Placemark> placemarks = await Future(
            () => _geolocator.placemarkFromAddress(_addressTextController.text))
        .catchError((onError) {
      _showMyDialog(
          'Nie udało się znaleźć podanego miejsca', onError.toString());
    });

    if (placemarks != null && placemarks.isNotEmpty) {
      final Placemark pos = placemarks[0];

      setState(() {
        _currentPosition = new Position(
            latitude: pos.position.latitude, longitude: pos.position.longitude);
        forecast = fetchAndSetForecast();
      });
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
      title: TextField(
        decoration: InputDecoration(
          hintText: 'Wpisz nazwę ulicy',
          suffixIcon: IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              _onLookupCoordinatesPressed();
            },
          ),
        ),
        controller: _addressTextController,
      ),
      centerTitle: true,
      leading: IconButton(
          icon: Icon(Icons.my_location),
          onPressed: () {
            _initCurrentLocation();
          }),
    );

    List<Widget> _buildDataView(AsyncSnapshot<Forecast> snapshot) {
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

    List<Widget> _buildError() {
      return <Widget>[
        const Padding(
          padding: EdgeInsets.only(top: 16),
          child: Text('włacz neta i lokacje'),
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
          future: forecast,
          builder: (context, snapshot) {
            List<Widget> children;
            if (snapshot.connectionState != ConnectionState.done) {
              children = _buildLoader();
            }
            if (snapshot.hasError) {
              print('ERRRRRROOOOORRRR');
              children = _buildError();
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
