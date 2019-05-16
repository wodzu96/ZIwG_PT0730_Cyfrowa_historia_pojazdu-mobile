import 'package:cyfrowa_historia_pojazdu/communication/model/CarDamage.dart';
import 'package:cyfrowa_historia_pojazdu/core/core_page.dart';
import 'package:cyfrowa_historia_pojazdu/ui/CarDamageCreate/car_damage_create_builder.dart';
import 'package:cyfrowa_historia_pojazdu/ui/CarDamageCreate/car_damage_create_service.dart';
import 'package:flutter/material.dart';

class CarDamageCreateScreen extends StatefulWidget
    implements CorePage<CarDamageCreateBuilder, CarDamageCreateService> {
  const CarDamageCreateScreen({Key key, @required this.carName})
      : super(key: key);

  final String carName;

  @override
  CarDamageCreateScreenState createState() => new CarDamageCreateScreenState();

  @override
  get builder => CarDamageCreateBuilder();

  @override
  get service => CarDamageCreateService();
}

class CarDamageCreateScreenState extends State<CarDamageCreateScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _formAutoValidate = false;
  bool _isLoading = false;
  DateTime _damageDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        primary: true,
        appBar: AppBar(
          title: Text("Dodaj usterkę"),
        ),
        body: widget.builder.buildRootLayout(
            context,
            _isLoading,
            _formKey,
            _formAutoValidate,
            _onCarDamageCreateButtonPressed,
            _damageDate,
            _onDateChanged));
  }

  void _onDateChanged(DateTime date) {
    setState(() {
      _damageDate = date;
    });
  }

  void _onCarDamageCreateButtonPressed(String name, String description,
      String course) {
    if (_formKey.currentState.validate()) {
      _performCarDamageCreate(
          CarDamage(name, description, int.parse(course), _damageDate),
          widget.carName);
    } else {
      _setStateAutoValidateForm(true);
    }
  }

  void _performCarDamageCreate(CarDamage carDamage, String carName) {
    _setStateLoading(true);
    widget.service
        .addDamageToCar(carDamage, carName)
        .then((value) => _onCarDamageCreateSuccess())
        .catchError((dynamic error) => _onCarDamageCreateError(error));
  }

  void _onCarDamageCreateError(dynamic error) {
    _setStateLoading(false);
    widget.builder.showErrorDialog(
        context, "Nie udało się dodać usterki. Spróbuj ponownie.", () {});
    print(error.details);
  }

  void _onCarDamageCreateSuccess() {
    _setStateLoading(false);
    widget.builder.showSuccessDialog(context, "Usterka została dodana.", () {
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
