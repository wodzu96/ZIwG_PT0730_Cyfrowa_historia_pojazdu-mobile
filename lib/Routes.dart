import 'package:flutter/material.dart';
import 'package:cyfrowa_historia_pojazdu/ui/Login/index.dart';
import 'package:cyfrowa_historia_pojazdu/ui/SignUp/index.dart';
import 'package:cyfrowa_historia_pojazdu/ui/Home/index.dart';
import 'package:cyfrowa_historia_pojazdu/theme/style.dart';

class Routes {

  var routes = <String, WidgetBuilder>{
    "/SignUp": (BuildContext context) => new SignUpScreen(),
    "/HomePage": (BuildContext context) => new HomeScreen()
  };

  Routes() {
    runApp(new MaterialApp(
      title: "Flutter Flat App",
      home: new LoginScreen(),
      theme: appTheme,
      routes: routes,
    ));
  }
}
