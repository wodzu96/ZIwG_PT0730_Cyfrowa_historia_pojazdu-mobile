import 'package:cyfrowa_historia_pojazdu/communication/FirebaseDatabaseService.dart';
import 'package:cyfrowa_historia_pojazdu/communication/model/CarFix.dart';
import 'package:cyfrowa_historia_pojazdu/communication/model/car.dart';
import 'package:cyfrowa_historia_pojazdu/communication/model/userdata.dart';
import 'package:firebase_database/firebase_database.dart';
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
    FirebaseDatabaseService().addUserToDatabase(UserData("Piotr Wodzyński", "p.wodzu96@gmail.com"));
    FirebaseDatabaseService().addCarToUser(Car("Mazda", "EBE76RJ", "12098098", DateTime.now()));
    CarFix carFix = CarFix("Olej", "Wymiana oleju", 3, DateTime.now(), "Wymiana eksploatacyjna");
    FirebaseDatabaseService().addFixToCar(carFix, "Mazda");
    runApp(new MaterialApp(
      title: "Flutter Flat App",
      home: new LoginScreen(),
      theme: appTheme,
      routes: routes,
    ));
  }
}
