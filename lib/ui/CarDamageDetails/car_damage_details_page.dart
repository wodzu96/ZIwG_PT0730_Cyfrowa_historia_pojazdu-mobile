import 'package:cyfrowa_historia_pojazdu/communication/model/CarDamage.dart';
import 'package:cyfrowa_historia_pojazdu/core/core_page.dart';
import 'package:cyfrowa_historia_pojazdu/ui/CarDamageDetails/car_damage_details_builder.dart';
import 'package:cyfrowa_historia_pojazdu/ui/CarDamageDetails/car_damage_details_service.dart';
import 'package:flutter/material.dart';

class CarDamageDetailsScreen extends StatefulWidget
    implements CorePage<CarDamageDetailsBuilder, CarDamageDetailsService> {
  final CarDamage carDamage;
  final String carName;
  CarDamageDetailsScreen({Key key,  @required this.carDamage, @required this.carName}) : super(key: key);

  @override
  _CarDamageDetailsScreenState createState() =>  _CarDamageDetailsScreenState(carDamage, carName);

  @override
  get builder => CarDamageDetailsBuilder();

  @override
  get service => CarDamageDetailsService();
}

class _CarDamageDetailsScreenState extends State<CarDamageDetailsScreen> {
  CarDamage _carDamage;
  String _carName;

  _CarDamageDetailsScreenState(this._carDamage, this._carName);
  bool _isLoading = true;


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        primary: true,
        appBar: AppBar(
          title: Text("Szczegóły uszkodzenia"),
        ),
        body: widget.builder
            .buildRootLayout(widget.service, _carName, context, _isLoading, _refresh, _carDamage));
  }

  @override
  void initState() {
    _refresh();
    super.initState();
  }

  Future<dynamic> _refresh() async {
    _setStateCarDamage(_carDamage);
    _setStateLoading(false);
    
    return Future;
  }

  void _setStateLoading(bool isLoading) {
    setState(() {
      _isLoading = isLoading;
    });
  }

  void _setStateCarDamage(CarDamage carDamage) {
    setState(() {
      this._carDamage = carDamage;
    });
  }
}
