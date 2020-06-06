import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:weather_app/models/hourly.dart';

class StackedAreaLineChart extends StatelessWidget {
  final List<Hourly> hourlyForecast;

  StackedAreaLineChart(this.hourlyForecast);

  @override
  Widget build(BuildContext context) {
    return new charts.LineChart(
      _createData(),
      defaultRenderer:
          new charts.LineRendererConfig(includeArea: true, stacked: false),
      animate: true,
      primaryMeasureAxis: new charts.NumericAxisSpec(
          tickFormatterSpec: charts.BasicNumericTickFormatterSpec(
              (num value) => '${value.round()}°C')),
      selectionModels: [
        charts.SelectionModelConfig(
            changedListener: (charts.SelectionModel model) {
          if (model.hasDatumSelection)
            print(model.selectedSeries[0]
                .measureFn(model.selectedDatum[0].index));
        })
      ],
    );
  }

  final now = DateTime.now();

  List<charts.Series<LinearTemperature, int>> _createData() {
    final todayData = [
      new LinearTemperature(0, hourlyForecast[0].temp),
      new LinearTemperature(1, hourlyForecast[1].temp),
      new LinearTemperature(2, hourlyForecast[2].temp),
      new LinearTemperature(3, hourlyForecast[3].temp),
      new LinearTemperature(4, hourlyForecast[4].temp),
      new LinearTemperature(5, hourlyForecast[5].temp),
      new LinearTemperature(6, hourlyForecast[6].temp),
      new LinearTemperature(7, hourlyForecast[7].temp),
      new LinearTemperature(8, hourlyForecast[8].temp),
      new LinearTemperature(9, hourlyForecast[9].temp),
      new LinearTemperature(10, hourlyForecast[10].temp),
      new LinearTemperature(11, hourlyForecast[11].temp),
      new LinearTemperature(12, hourlyForecast[12].temp),
      new LinearTemperature(13, hourlyForecast[13].temp),
      new LinearTemperature(14, hourlyForecast[14].temp),
      new LinearTemperature(15, hourlyForecast[15].temp),
      new LinearTemperature(16, hourlyForecast[16].temp),
      new LinearTemperature(17, hourlyForecast[17].temp),
      new LinearTemperature(18, hourlyForecast[18].temp),
      new LinearTemperature(19, hourlyForecast[19].temp),
      new LinearTemperature(20, hourlyForecast[20].temp),
      new LinearTemperature(21, hourlyForecast[21].temp),
      new LinearTemperature(22, hourlyForecast[22].temp),
      new LinearTemperature(23, hourlyForecast[23].temp),
    ];

    final tomorrowData = [
      new LinearTemperature(0, hourlyForecast[24].temp),
      new LinearTemperature(1, hourlyForecast[25].temp),
      new LinearTemperature(2, hourlyForecast[26].temp),
      new LinearTemperature(3, hourlyForecast[27].temp),
      new LinearTemperature(4, hourlyForecast[28].temp),
      new LinearTemperature(5, hourlyForecast[29].temp),
      new LinearTemperature(6, hourlyForecast[30].temp),
      new LinearTemperature(7, hourlyForecast[31].temp),
      new LinearTemperature(8, hourlyForecast[32].temp),
      new LinearTemperature(9, hourlyForecast[33].temp),
      new LinearTemperature(10, hourlyForecast[34].temp),
      new LinearTemperature(11, hourlyForecast[35].temp),
      new LinearTemperature(12, hourlyForecast[36].temp),
      new LinearTemperature(13, hourlyForecast[37].temp),
      new LinearTemperature(14, hourlyForecast[38].temp),
      new LinearTemperature(15, hourlyForecast[39].temp),
      new LinearTemperature(16, hourlyForecast[40].temp),
      new LinearTemperature(17, hourlyForecast[41].temp),
      new LinearTemperature(18, hourlyForecast[42].temp),
      new LinearTemperature(19, hourlyForecast[43].temp),
      new LinearTemperature(20, hourlyForecast[44].temp),
      new LinearTemperature(21, hourlyForecast[45].temp),
      new LinearTemperature(22, hourlyForecast[46].temp),
      new LinearTemperature(23, hourlyForecast[47].temp),
    ];

    return [
      new charts.Series<LinearTemperature, int>(
        id: 'today',
        colorFn: (_, __) => charts.MaterialPalette.deepOrange.shadeDefault,
        domainFn: (LinearTemperature temperature, _) => temperature.hour,
        measureFn: (LinearTemperature temperature, _) =>
            temperature.temperature,
        data: todayData,
      ),
      new charts.Series<LinearTemperature, int>(
        id: 'tomorrow',
        colorFn: (_, __) => charts.MaterialPalette.purple.shadeDefault,
        domainFn: (LinearTemperature temperature, _) => temperature.hour,
        measureFn: (LinearTemperature temperature, _) =>
            temperature.temperature,
        data: tomorrowData,
      ),
    ];
  }
}

class LinearTemperature {
  final int hour;
  final double temperature;

  LinearTemperature(this.hour, this.temperature);
}
