import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:weather_app/widgets/forecast_tabs.dart';

class RankineSplashScreen extends StatelessWidget {
  const RankineSplashScreen({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SplashScreen(
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
    );
  }
}
