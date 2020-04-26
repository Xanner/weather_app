import './current.dart';
import './daily.dart';
import './hourly.dart';

class Forecast {
  String timezone;
  Current current;
  List<Hourly> hourly;
  List<Daily> daily;

  Forecast({this.timezone, this.current, this.hourly, this.daily});

  Forecast.fromJson(Map<String, dynamic> json) {
    timezone = json['timezone'];
    current =
        json['current'] != null ? new Current.fromJson(json['current']) : null;
    if (json['hourly'] != null) {
      hourly = new List<Hourly>();
      json['hourly'].forEach((v) {
        hourly.add(new Hourly.fromJson(v));
      });
    }
    if (json['daily'] != null) {
      daily = new List<Daily>();
      json['daily'].forEach((v) {
        daily.add(new Daily.fromJson(v));
      });
    }
  }
}
