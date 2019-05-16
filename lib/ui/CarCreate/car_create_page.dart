import 'package:cyfrowa_historia_pojazdu/communication/model/Car.dart';
import 'package:cyfrowa_historia_pojazdu/core/core_page.dart';
import 'package:cyfrowa_historia_pojazdu/ui/CarCreate/car_create_builder.dart';
import 'package:cyfrowa_historia_pojazdu/ui/CarCreate/car_create_service.dart';
import 'package:flutter/material.dart';

class CarCreateScreen extends StatefulWidget
    implements CorePage<CarCreateBuilder, CarCreateService> {
  const CarCreateScreen({Key key, @required this.carName}) : super(key: key);

  final String carName;

  @override
  CarCreateScreenState createState() => new CarCreateScreenState();

  @override
  get builder => CarCreateBuilder();

  @override
  get service => CarCreateService();
}

class CarCreateScreenState extends State<CarCreateScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _formAutoValidate = false;
  bool _isLoading = false;
  DateTime _date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        primary: true,
        appBar: AppBar(
          title: Text("Dodaj samoch"),
        ),
        body: widget.builder.buildRootLayout(
            context,
            _isLoading,
            _formKey,
            _formAutoValidate,
            _onCarCreateButtonPressed,
            _date,
            _onDateChanged));
  }

  void _onDateChanged(DateTime date) {
    setState(() {
      _date = date;
    });
  }

  void _onCarCreateButtonPressed(String name, String register, String vin) {
    if (_formKey.currentState.validate()) {
      _performCarCreate(Car(name, register, vin, _date));
    } else {
      _setStateAutoValidateForm(true);
    }
  }

  void _performCarCreate(Car car) {
    _setStateLoading(true);
    widget.service
        .addCarToUser(car)
        .then((value) => _onCarCreateSuccess())
        .catchError((dynamic error) => _onCarCreateError(error));
  }

  void _onCarCreateError(dynamic error) {
    _setStateLoading(false);
    widget.builder.showErrorDialog(
        context, "Nie udało się dodać pojazdu. Spróbuj ponownie.", () {});
    print(error.details);
  }

  void _onCarCreateSuccess() {
    _setStateLoading(false);
    widget.builder.showSuccessDialog(context, "Pojazd został dodany.", () {
      Navigator.of(context).pop();
    });
  }

  void _setStateLoading(bool isLoading) {
    setState(() {
      _isLoading = isLoading;
    });
  }

  void _setStateAutoValidateForm(bool autoValidate) {
    setState(() {
      _formAutoValidate = autoValidate;
    });
  }
}
