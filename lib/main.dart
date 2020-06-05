import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:weather_app/screens/rankine_splash_screen.dart';
import 'package:weather_app/widgets/splash_logo_widget.dart';

void main() => runApp(RankineApp());

class RankineApp extends StatefulWidget {
  @override
  _RankineAppState createState() => _RankineAppState();
}

class _RankineAppState extends State<RankineApp> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      title: 'Rankine',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.transparent,
        brightness: Brightness.dark,
      ),
      home: Stack(
        children: <Widget>[
          RankineSplashScreen(),
          SplashLogoWidget(),
        ],
      ),
    );
  }
}
