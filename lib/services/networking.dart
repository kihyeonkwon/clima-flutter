import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class NetworkHelper {
  final String appid;
  final double lat;
  final double lon;

  NetworkHelper(this.lat, this.lon, this.appid);

  Future getWeather() async {
    var url = Uri.https('api.openweathermap.org', '/data/2.5/weather',
        {'lat': '$lat', 'lon': '$lon', 'appid': '$appid', 'units': 'metric'});

    var response = await http.get(url);

    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      return jsonResponse;
    } else {
      print(response.statusCode);
    }
  }
}
