import './weather.dart';

class Current {
  int dt;
  int sunrise;
  int sunset;
  double temp;
  double feelsLike;
  int pressure;
  int humidity;
  double uvi;
  double windSpeed;
  List<Weather> weather;

  Current(
      {this.dt,
      this.sunrise,
      this.sunset,
      this.temp,
      this.feelsLike,
      this.pressure,
      this.humidity,
      this.uvi,
      this.windSpeed,
      this.weather});

  Current.fromJson(Map<String, dynamic> json) {
    dt = json['dt'];
    sunrise = json['sunrise'];
    sunset = json['sunset'];
    temp = json['temp'].toDouble();
    feelsLike = json['feels_like'].toDouble();
    pressure = json['pressure'];
    humidity = json['humidity'];
    uvi = json['uvi'].toDouble();
    windSpeed = json['wind_speed'].toDouble();
    if (json['weather'] != null) {
      weather = new List<Weather>();
      json['weather'].forEach((v) {
        weather.add(new Weather.fromJson(v));
      });
    }
  }
}
