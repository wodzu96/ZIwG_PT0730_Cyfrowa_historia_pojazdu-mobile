import 'package:cyfrowa_historia_pojazdu/ui/CarFixCreate/car_fix_create_page.dart';
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
      home: new CarFixCreateScreen(
        carName: "ASD",
      ),
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        brightness: Brightness.dark,
        accentColor: Colors.white,
      ),
      routes: routes,
    ));
  }
}
