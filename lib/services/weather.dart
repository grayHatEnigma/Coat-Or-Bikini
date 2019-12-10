import 'package:coat_or_bikini/services/network_helper.dart';
import 'package:coat_or_bikini/services/location.dart';

// api key
const apiKey = 'ce10b82f42fed851015dac4ebc6a6528';

class WeatherModel {
  Future<dynamic> getLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();
    print('Latitude: ${location.latitude} , Longitude: ${location.longitude}');
    String url =
        'https://api.openweathermap.org/data/2.5/weather?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric';
    NetworkHelper networking = NetworkHelper(url: url);
    var weatherData = await networking.getWeatherData();

    return weatherData;
  }

  Future<dynamic> getCityWeather({String cityName}) async {
    String url =
        'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey&units=metric';
    NetworkHelper networkHelper = NetworkHelper(url: url);
    var weatherData = await networkHelper.getWeatherData();
    return weatherData;
  }
}
