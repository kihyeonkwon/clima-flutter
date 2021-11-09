import 'package:flutter/material.dart';
import 'package:clima/services/location.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

const appid = '4af4d07cb88e48380fc2418e6f5646d7';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  double lat;
  double lon;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocation();
  }

  void getLocation() async {
    Location location = Location();
    await location.getLocation();
    lat = location.latitude;
    lon = location.longitude;
  }

  void getWeather() async {
    var url = Uri.https('api.openweathermap.org', '/data/2.5/weather',
        {'lat': '$lat', 'lon': '$lon', 'appid': '$appid'});

    var response = await http.get(url);

    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      print(jsonResponse);
      double temp = jsonResponse["main"]["temp"];
      int condition = jsonResponse["weather"][0]["id"];
      String city = jsonResponse["name"];
    } else {
      print(response.statusCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RaisedButton(
          onPressed: () {
            getWeather();
          },
          child: Text('Get Location'),
        ),
      ),
    );
  }
}
