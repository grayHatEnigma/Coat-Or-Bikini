import 'package:coat_or_bikini/services/weather.dart';
import 'package:coat_or_bikini/utilities/constants.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class LocationScreen extends StatefulWidget {
  final locationWeather;

  LocationScreen({this.locationWeather});

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  int temperature;
  String img;
  String weatherIcon;
  String cityName;
  WeatherModel weatherModel = WeatherModel();
  DateTime date = DateTime.now();
  bool isVisible = true;
  @override
  void initState() {
    super.initState();
    if (widget.locationWeather != null) {
      updateUI(widget.locationWeather);
    } else {
      isVisible = false;
    }
  }

  void updateUI(var weatherData) {
    setState(() {
      if (weatherData != null) {
        print(weatherData);
        var temp = weatherData['main']['temp'];
        temperature = temp.toInt();
        weatherIcon = weatherData['weather'][0]['icon'];
        cityName = weatherData['name'];
        isVisible = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!isVisible) {
      return Scaffold(
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('images/background.jpg'), fit: BoxFit.fill),
              color: Colors.black),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'No Internet Connection',
                  textAlign: TextAlign.center,
                  style: kErrorTextStyle,
                ),
                SizedBox(
                  height: 10,
                ),
                RaisedButton(
                  color: Colors.blue,
                  child: Text(
                    "Try Again",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  onPressed: () => Navigator.pushNamed(context, '/'),
                )
              ],
            ),
          ),
        ),
      );
    }
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/background.jpg'), fit: BoxFit.fill),
            color: Colors.black),
        child: Visibility(
          visible: isVisible,
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  formatDate(date, [DD, ' - ', dd, ' ', M]),
                  style: kTimeTextStyle,
                ),
                Column(
                  children: <Widget>[
                    Image(
                      image: NetworkImage(
                          'http://openweathermap.org/img/wn/$weatherIcon@2x.png'),
                    ),
                    Text(
                      '${temperature.toString()} °C',
                      style: kTempTextStyle,
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Text(
                      '$cityName',
                      textAlign: TextAlign.center,
                      style: kMessageTextStyle,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 40),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          FlatButton(
                            onPressed: () async {
                              var weatherData =
                                  await weatherModel.getLocationWeather();
                              updateUI(weatherData);
                            },
                            child: Icon(Icons.near_me,
                                size: 50.0, color: Colors.white),
                          ),
                          FlatButton(
                            onPressed: () async {
                              var typedName = await Navigator.pushNamed(
                                  context, '/city_screen');
                              print(typedName);
                              if (typedName != null) {
                                var weatherData = await weatherModel
                                    .getCityWeather(cityName: typedName);

                                updateUI(weatherData);
                              }
                            },
                            child: Icon(Icons.location_city,
                                size: 50.0, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
