import './weather.dart';
import './rain.dart';

class Hourly {
  int dt;
  double temp;
  double feelsLike;
  int pressure;
  int humidity;
  int clouds;
  double windSpeed;
  int windDeg;
  List<Weather> weather;
  Rain rain;

  Hourly(
      {this.dt,
      this.temp,
      this.feelsLike,
      this.pressure,
      this.humidity,
      this.clouds,
      this.windSpeed,
      this.weather,
      this.rain});

  Hourly.fromJson(Map<String, dynamic> json) {
    dt = json['dt'];
    temp = json['temp'].toDouble();
    feelsLike = json['feels_like'].toDouble();
    pressure = json['pressure'];
    humidity = json['humidity'];
    clouds = json['clouds'];
    windSpeed = json['wind_speed'].toDouble();
    if (json['weather'] != null) {
      weather = new List<Weather>();
      json['weather'].forEach((v) {
        weather.add(new Weather.fromJson(v));
      });
    }
    rain = json['rain'] != null ? new Rain.fromJson(json['rain']) : null;
  }
}
