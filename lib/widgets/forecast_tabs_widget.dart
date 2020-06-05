import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart' hide LocationAccuracy;
import 'package:weather_app/models/forecast.dart';
import 'package:weather_app/screens/current_weather_screen.dart';
import 'package:weather_app/screens/future_forecast_screen.dart';
import 'package:weather_app/screens/tomorrow_weather_screen.dart';
import 'package:weather_app/widgets/geolocation_widget.dart';

class ForecastTabsWidget extends StatefulWidget {
  const ForecastTabsWidget({
    Key key,
    @required this.androidFusedLocation,
  }) : super(key: key);

  final bool androidFusedLocation;
  @override
  _ForecastTabsWidgetState createState() => _ForecastTabsWidgetState();
}

class _ForecastTabsWidgetState extends State<ForecastTabsWidget> {
  final Geolocator _geolocator = Geolocator();
  final TextEditingController _addressTextController = TextEditingController();

  bool _isDialogOpen;
  Position _currentPosition;
  Future<Forecast> forecast;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    setState(() {
      _isDialogOpen = false;
      forecast = _fetchAndSetForecast();
    });
  }

  void _getCurrentLocation() {
    _openLocationSetting();
    Geolocator()
      ..forceAndroidLocationManager = !widget.androidFusedLocation
      ..getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
      ).then((position) {
        if (mounted) {
          setState(() {
            _currentPosition = position;
            forecast = _fetchAndSetForecast();
            _addressTextController.text =
                'XD'; //TODO ustawic na nazwe lokalizacji
          });
        }
      }).catchError((e) {
        print(e);
      });
  }

  Future<void> _showAlertDialog(String title, String info) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          titleTextStyle: TextStyle(color: Colors.black54),
          contentTextStyle: TextStyle(color: Colors.black54),
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
              child: Text(
                'OK',
                style: TextStyle(color: Colors.black54),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<Forecast> _fetchAndSetForecast() async {
    await _checkInternetConnection();
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
      _showAlertDialog(
        'Nie udało się pobrać danych',
        'Niestety nie udało się pobrać danych :( spróbuj ponownie za chwilę.', //TODO sprawdzic kiedy sie uruchomi
      );
    }
  }

  Future _checkInternetConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
      }
    } on SocketException catch (_) {
      print('not connected');
      if (_isDialogOpen == false) {
        _showAlertDialog(
          'Brak połaczenia z internetem',
          'Aby wyszukać aktualną pogodę podłącz się do sieci i kliknij OK.',
        );
        setState(() {
          _isDialogOpen = true;
        });
      }
    }
  }

  void _openLocationSetting() async {
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

  Future<void> _findPlace() async {
    final List<Placemark> placemarks = await Future(
            () => _geolocator.placemarkFromAddress(_addressTextController.text))
        .catchError((onError) {
      _showAlertDialog(
        'Nie udało się znaleźć podanego miejsca',
        onError.toString(), //TODO zrobic porzadek
      );
    });

    if (placemarks != null && placemarks.isNotEmpty) {
      final Placemark pos = placemarks[0];

      setState(() {
        _currentPosition = new Position(
          latitude: pos.position.latitude,
          longitude: pos.position.longitude,
        );
        forecast = _fetchAndSetForecast();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
              _findPlace();
            },
          ),
        ),
        controller: _addressTextController,
      ),
      centerTitle: true,
      leading: IconButton(
          icon: Icon(Icons.my_location),
          onPressed: () {
            _getCurrentLocation();
          }),
    );

    return GeolocationWidget(
      appBar: appBar,
      forecast: forecast,
    );
  }
}