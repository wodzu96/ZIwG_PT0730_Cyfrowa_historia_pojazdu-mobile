import 'package:cyfrowa_historia_pojazdu/communication/model/CarFix.dart';
import 'package:cyfrowa_historia_pojazdu/core/core_page.dart';
import 'package:cyfrowa_historia_pojazdu/ui/CarFixDetails/car_fix_details_builder.dart';
import 'package:cyfrowa_historia_pojazdu/ui/CarFixDetails/car_fix_details_service.dart';
import 'package:flutter/material.dart';

class CarFixDetailsScreen extends StatefulWidget
    implements CorePage<CarFixDetailsBuilder, CarFixDetailsService> {
  final CarFix carFix;
  final String carName;

  CarFixDetailsScreen({Key key, @required this.carFix, @required this.carName})
      : super(key: key);

  @override
  CarFixDetailsScreenState createState() =>
      new CarFixDetailsScreenState(carFix, carName);

  @override
  get builder => CarFixDetailsBuilder();

  @override
  get service => CarFixDetailsService();
}

class CarFixDetailsScreenState extends State<CarFixDetailsScreen> {
  CarFix carFix;
  String _carName;

  CarFixDetailsScreenState(this.carFix, this._carName);
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        primary: true,
        appBar: AppBar(
          title: Text("Szczegóły naprawy"),
        ),
        body: widget.builder.buildRootLayout(
            widget.service, _carName, context, _isLoading, _refresh, carFix));
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
      this.carFix = carFix;
    });
  }
}
