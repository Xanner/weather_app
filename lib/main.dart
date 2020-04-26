import 'package:flutter/material.dart';
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
      home: DefaultTabController(
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
          child: ForecastTabs(),
        ),
      ),
    );
  }
}
