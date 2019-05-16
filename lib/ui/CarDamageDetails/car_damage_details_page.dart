import 'package:cyfrowa_historia_pojazdu/communication/model/CarDamage.dart';
import 'package:cyfrowa_historia_pojazdu/core/core_page.dart';
import 'package:cyfrowa_historia_pojazdu/ui/CarDamageDetails/car_damage_details_builder.dart';
import 'package:cyfrowa_historia_pojazdu/ui/CarDamageDetails/car_damage_details_service.dart';
import 'package:flutter/material.dart';

class CarDamageDetailsScreen extends StatefulWidget
    implements CorePage<CarDamageDetailsBuilder, CarDamageDetailsService> {
  const CarDamageDetailsScreen({Key key}) : super(key: key);

  @override
  CarDamageDetailsScreenState createState() =>
      new CarDamageDetailsScreenState();

  @override
  get builder => CarDamageDetailsBuilder();

  @override
  get service => CarDamageDetailsService();
}

class CarDamageDetailsScreenState extends State<CarDamageDetailsScreen> {
  bool _isLoading = false;
  CarDamage _carDamage = CarDamage(
      "NAPR82764",
      "Auto po zderzeniu czołowym z helikopterem AH-64, przy prędkości około 367,5km/h, wymienione wszystko poza lusterkiem przednim lewym",
      100000,
      DateTime.now());

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        primary: true,
        appBar: AppBar(
          title: Text("Szczegóły naprawy"),
        ),
        body: widget.builder
            .buildRootLayout(context, _isLoading, _refresh, _carDamage));
  }

  Future<dynamic> _refresh() async {
    return Future;
  }

  void _setStateLoading(bool isLoading) {
    setState(() {
      _isLoading = isLoading;
    });
  }

  void _setStateCarDamage(CarDamage carDamage) {
    setState(() {
      _carDamage = carDamage;
    });
  }
}
