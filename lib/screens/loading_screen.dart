import 'package:coat_or_bikini/screens/location_screen.dart';
import 'package:coat_or_bikini/services/weather.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  bool timeOut = true;

  @override
  void initState() {
    super.initState();
    // Get Location Data as soon as the loading screen gets created
    getLocationData();
  }

  void getLocationData() async {
    Future.delayed(Duration(seconds: 7), () {
      if (timeOut) {
        print('Excuting Future.delayed()');
        print('Time Out !');
        Alert(
          context: context,
          type: AlertType.none,
          title: "Location Error",
          desc:
              "Please check that your Location is enabled first then try again.",
          buttons: [
            DialogButton(
              child: Text(
                "Try Again",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () => Navigator.pushNamed(context, '/'),
              width: 120,
            )
          ],
        ).show();
      }

      print('Request Time Out ? $timeOut');
    });
    var weatherData = await WeatherModel().getLocationWeather();
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => LocationScreen(
            locationWeather: weatherData,
          ),
        ),
        (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.black,
        ),
        child: SpinKitFadingCircle(
          color: Colors.white,
          size: 70.0,
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    timeOut = false;
  }
}
