import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  final String url;
  NetworkHelper({@required this.url});

  Future<dynamic> getWeatherData() async {
    try {
      http.Response response = await http.get(url);
      if (response.statusCode == 200) {
        var weatherData = jsonDecode(response.body);

        return weatherData;
      }
    } catch (e) {
      print('Error in connecting to OpenWeatherApi, code: $e');
    }
  }
}
