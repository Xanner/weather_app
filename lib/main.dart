import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import './widgets/forecast_tabs.dart';

void main() => runApp(RankineApp());

class RankineApp extends StatefulWidget {
  @override
  _RankineAppState createState() => _RankineAppState();
}

class _RankineAppState extends State<RankineApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rankine',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.transparent,
        brightness: Brightness.dark,
      ),
      home: Stack(
        children: <Widget>[
          SplashScreen(
            seconds: 4,
            navigateAfterSeconds: DefaultTabController(
              length: 3,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      const Color.fromARGB(255, 255, 186, 163),
                      const Color.fromARGB(255, 238, 204, 168),
                    ],
                  ),
                ),
                child: ForecastTabs(androidFusedLocation: true),
              ),
            ),
            gradientBackground: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                const Color.fromARGB(255, 255, 186, 163),
                const Color.fromARGB(255, 238, 204, 168),
              ],
            ),
            loaderColor: Colors.transparent,
          ),
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/icons/splash_logo.png"),
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
