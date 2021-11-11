import 'package:flutter/material.dart';
import 'package:clima/services/location.dart';
import '../services/networking.dart';

const appid = '4af4d07cb88e48380fc2418e6f5646d7';

class WeatherModel {
  Future<dynamic> getLocationWeather() async {
    Location location = Location();
    await location.getLocation();
    double lat = location.latitude;
    double lon = location.longitude;
    NetworkHelper networkHelper = NetworkHelper(lat, lon, appid);
    var weatherData = await networkHelper.getWeather();
    return weatherData;
  }

  Future<dynamic> getCityWeather(cityName) async {
    NetworkHelperCity networkHelperCity = NetworkHelperCity(cityName, appid);
    var weatherData = networkHelperCity.getWeather();
    return weatherData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
