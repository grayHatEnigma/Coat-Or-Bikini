import 'package:flutter/material.dart';
import 'package:coat_or_bikini/screens/city_screen.dart';
import 'package:coat_or_bikini/screens/loading_screen.dart';
import 'package:coat_or_bikini/screens/location_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => LoadingScreen(),
        '/location_screen': (context) => LocationScreen(),
        '/city_screen': (context) => CityScreen(),
      },
    );
  }
}
