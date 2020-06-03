import 'dart:convert';
import 'package:flutter/services.dart';

class City {
  int id;
  String name;
  String state;
  String country;

  City({
    this.id,
    this.name,
    this.state,
    this.country,
  });

  factory City.fromJson(Map<String, dynamic> parsedJson) {
    return City(
      id: parsedJson['id'],
      name: parsedJson['name'] as String,
      state: parsedJson['state'] as String,
      country: parsedJson['country'] as String,
    );
  }
}

class Cities {
  static List<City> cities;

  static Future loadCities() async {
    try {
      cities = new List<City>();
      String jsonString = await rootBundle.loadString('assets/cityList.json');
      Map parsedJson = json.decode(jsonString);
      var categoryJson = parsedJson['cities'] as List;
      for (int i = 0; i < categoryJson.length; i++) {
        cities.add(new City.fromJson(categoryJson[i]));
      }
    } catch (e) {
      print(e);
    }
  }
}
