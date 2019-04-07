import 'package:cyfrowa_historia_pojazdu/ui/Home/index.dart';
import 'package:cyfrowa_historia_pojazdu/ui/Login/login_page.dart';
import 'package:cyfrowa_historia_pojazdu/ui/SignUp/signup_page.dart';
import 'package:flutter/material.dart';

class Routes {
  var routes = <String, WidgetBuilder>{
    "/SignUp": (BuildContext context) => new SignUpScreen(),
    "/HomePage": (BuildContext context) => new HomeScreen()
  };

  Routes() {
    runApp(new MaterialApp(
      title: "Flutter Flat App",
      home: new LoginScreen(),
      theme: ThemeData(
          brightness: Brightness.dark,
          accentColor: Colors.white,
          buttonColor: Colors.green),
      routes: routes,
    ));
  }
}
