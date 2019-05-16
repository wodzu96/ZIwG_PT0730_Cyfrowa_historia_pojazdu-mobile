import 'package:cyfrowa_historia_pojazdu/ui/CarDamageDetails/car_damage_details_page.dart';
import 'package:cyfrowa_historia_pojazdu/ui/Home/home_page.dart';
import 'package:cyfrowa_historia_pojazdu/ui/SignUp/signup_page.dart';
import 'package:flutter/material.dart';

class Routes {
  var routes = <String, WidgetBuilder>{
    "/SignUp": (BuildContext context) => new SignUpScreen(),
    "/HomePage": (BuildContext context) => new HomePage()
  };

  Routes() {
    runApp(new MaterialApp(
      title: "Flutter Flat App",
      home: new HomePage(),
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        brightness: Brightness.dark,
        accentColor: Colors.white,
      ),
      routes: routes,
    ));
  }
}
