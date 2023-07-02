import 'dart:convert';
import 'package:climateapp/services/location.dart';
import 'package:climateapp/services/networking.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const apiKey = 'd09ac64575dd6cedf315b0d9d202cca3';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  double? latitude;
  double? longitude;
  @override
  void initState() {
    super.initState();
    _determinePositionData();
  }

  void _determinePositionData() async {
    Location location = Location();
    await location.determinePosition();
    latitude = location.latitude;
    longitude = location.longitude;

    var url = Uri.https('api.openweathermap.org', '/data/2.5/weather', {
      'lat': latitude.toString(),
      'lon': longitude.toString(),
      'appid': apiKey
    });
    NetWorkHelper networkHelper = NetWorkHelper(url);
    var weatherData = await networkHelper.getData();

    double temperature = weatherData['main']['temp'];
    int condition = weatherData['weather'][0]['id'];
    String cityName = weatherData['name'];
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}