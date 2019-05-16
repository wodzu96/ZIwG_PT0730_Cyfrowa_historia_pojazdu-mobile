import 'package:cyfrowa_historia_pojazdu/communication/model/CarFix.dart';
import 'package:cyfrowa_historia_pojazdu/core/core_page.dart';
import 'package:cyfrowa_historia_pojazdu/ui/CarFixDetails/car_fix_details_builder.dart';
import 'package:cyfrowa_historia_pojazdu/ui/CarFixDetails/car_fix_details_service.dart';
import 'package:flutter/material.dart';

class CarFixDetailsScreen extends StatefulWidget
    implements CorePage<CarFixDetailsBuilder, CarFixDetailsService> {
  const CarFixDetailsScreen({Key key}) : super(key: key);

  @override
  CarFixDetailsScreenState createState() => new CarFixDetailsScreenState();

  @override
  get builder => CarFixDetailsBuilder();

  @override
  get service => CarFixDetailsService();
}

class CarFixDetailsScreenState extends State<CarFixDetailsScreen> {
  bool _isLoading = false;
  CarFix _carFix = CarFix(
      "NAPR82764",
      "Auto po zderzeniu czołowym z helikopterem AH-64, przy prędkości około 367,5km/h, wymienione wszystko poza lusterkiem przednim lewym",
      100000,
      DateTime.now(),
      "Przypadki beznadziejne");

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        primary: true,
        appBar: AppBar(
          title: Text("Szczegóły naprawy"),
        ),
        body: widget.builder
            .buildRootLayout(context, _isLoading, _refresh, _carFix));
  }

  Future<dynamic> _refresh() async {
    return Future;
  }

  void _setStateLoading(bool isLoading) {
    setState(() {
      _isLoading = isLoading;
    });
  }

  void _setStateCarFix(CarFix carFix) {
    setState(() {
      _carFix = carFix;
    });
  }
}
