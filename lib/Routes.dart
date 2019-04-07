import 'package:cyfrowa_historia_pojazdu/communication/FirebaseDatabaseService.dart';
import 'package:cyfrowa_historia_pojazdu/communication/model/CarFix.dart';
import 'package:cyfrowa_historia_pojazdu/communication/model/Demage.dart';
import 'package:cyfrowa_historia_pojazdu/ui/Home/home_page.dart';
import 'package:cyfrowa_historia_pojazdu/ui/Login/login_page.dart';
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
          brightness: Brightness.dark,
          accentColor: Colors.white,
          buttonColor: Colors.green),
      routes: routes,
    ));
  }
}
