import 'package:cyfrowa_historia_pojazdu/communication/model/CarFix.dart';
import 'package:cyfrowa_historia_pojazdu/core/core_page.dart';
import 'package:cyfrowa_historia_pojazdu/ui/CarFixCreate/car_fix_create_builder.dart';
import 'package:cyfrowa_historia_pojazdu/ui/CarFixCreate/car_fix_create_service.dart';
import 'package:flutter/material.dart';

class CarFixCreateScreen extends StatefulWidget
    implements CorePage<CarFixCreateBuilder, CarFixCreateService> {
  const CarFixCreateScreen({Key key, @required this.carName}) : super(key: key);

  final String carName;

  @override
  CarFixCreateScreenState createState() => new CarFixCreateScreenState();

  @override
  get builder => CarFixCreateBuilder();

  @override
  get service => CarFixCreateService();
}

class CarFixCreateScreenState extends State<CarFixCreateScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _formAutoValidate = false;
  bool _isLoading = false;
  DateTime _fixDate = DateTime.now();
  String _fixCategory;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        primary: true,
        appBar: AppBar(
          title: Text("Dodaj naprawę"),
        ),
        body: widget.builder.buildRootLayout(
            context,
            _isLoading,
            _formKey,
            _formAutoValidate,
            _onCarFixCreateButtonPressed,
            _fixDate,
            _onDateChanged,
            _fixCategory,
            _onCategoryChanged));
  }

  void _onCategoryChanged(String category) {
    setState(() {
      _fixCategory = category;
    });
  }

  void _onDateChanged(DateTime date) {
    setState(() {
      _fixDate = date;
    });
  }

  void _onCarFixCreateButtonPressed(String name, String description,
      String course) {
    if (_formKey.currentState.validate()) {
      _performCarFixCreate(
          CarFix(name, description, int.parse(course), this._fixDate,
              this._fixCategory),
          widget.carName);
    } else {
      _setStateAutoValidateForm(true);
    }
  }

  void _performCarFixCreate(CarFix carFix, String carName) {
    _setStateLoading(true);
    widget.service
        .addFixToCar(carFix, carName)
        .then((value) => _onCarFixCreateSuccess())
        .catchError((dynamic error) => _onCarFixCreateError(error));
  }

  void _onCarFixCreateError(dynamic error) {
    _setStateLoading(false);
    widget.builder.showErrorDialog(
        context, "Nie udało się dodać naprawy. Spróbuj ponownie.", () {});
    print(error.details);
  }

  void _onCarFixCreateSuccess() {
    _setStateLoading(false);
    widget.builder.showSuccessDialog(context, "Naprawa została dodana.", () {
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
