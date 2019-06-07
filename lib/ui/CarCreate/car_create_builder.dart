import 'package:cyfrowa_historia_pojazdu/communication/validations.dart';
import 'package:cyfrowa_historia_pojazdu/core/core_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CarCreateBuilder with CoreBuilder, Validations {
  String name;
  String registration;
  String vin;
  DateTime date;

  Widget buildRootLayout(
      context,
      bool isLoading,
      GlobalKey<FormState> formKey,
      bool formAutoValidate,
      Function onSignupButtonPressed,
      damageDate,
      onDateChanged) {
    if (isLoading)
      return buildLoadingLayout(context);
    else
      return buildDefaultLayout(formKey, formAutoValidate,
          onSignupButtonPressed, context, damageDate, onDateChanged);
  }

  Widget buildDefaultLayout(
      GlobalKey<FormState> formKey,
      bool formAutoValidate,
      Function onSignupButtonPressed,
      BuildContext context,
      DateTime damageDate,
      Function onDateChanged) {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 32.0),
      children: <Widget>[
        SizedBox(height: 32.0),
        buildLoginForm(
            formKey, formAutoValidate, context, damageDate, onDateChanged),
        SizedBox(height: 32.0),
        buildSignupButton(formKey, onSignupButtonPressed)
      ],
    );
  }

  Widget buildLoginForm(GlobalKey<FormState> formKey, bool formAutoValidate,
      BuildContext context, DateTime damageDate, Function onDateChanged) {
    return Form(
      key: formKey,
      autovalidate: formAutoValidate,
      child: Column(
        children: <Widget>[
          SizedBox(
              height: 80.0,
              child: TextFormField(
                  validator: (value) {
                    return validateName(value);
                  },
                  onSaved: (value) => this.name = value,
                  decoration: InputDecoration(
                      hintText: 'Podaj nazwę', labelText: 'Nazwa'))),
          SizedBox(
              height: 80.0,
              child: TextFormField(
                  validator: (value) {
                    return validateName(value);
                  },
                  onSaved: (value) => this.registration = value,
                  decoration: InputDecoration(
                      hintText: 'Podaj numer rejestracyjny',
                      labelText: "Rejestracja"))),
          SizedBox(
              height: 80.0,
              child: TextFormField(
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    return validateEmpty(value);
                  },
                  onSaved: (value) => this.vin = value,
                  inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                  decoration: InputDecoration(
                      hintText: 'Podaj numer VIN', labelText: "VIN"))),
          SizedBox(
            height: 80.0,
            child: GestureDetector(
              onTap: () => _selectDate(context, damageDate, onDateChanged),
              child: AbsorbPointer(
                child: TextFormField(
                    controller: TextEditingController(
                        text: damageDate.toString().substring(0, 10)),
                    decoration: InputDecoration(
                        hintText: 'Dotknij, aby wybrać datę',
                        labelText: "Data rejestracji")),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildSignupButton(
      GlobalKey<FormState> formKey, Function onButtonPressed) {
    return SizedBox(
        height: 48.0,
        child: RaisedButton(
          onPressed: () {
            formKey.currentState.save();
            onButtonPressed(this.name, this.registration, this.vin);
          },
          color: Colors.blueGrey,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text('Dodaj pojazd', style: TextStyle(color: Colors.white)),
        ));
  }

  Future<Null> _selectDate(
      BuildContext context, DateTime damageDate, Function onDateChanged) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: damageDate,
        firstDate: damageDate.subtract(Duration(days: 365)),
        lastDate: damageDate.add(Duration(days: 365)));

    if (picked != null) {
      this.date = picked;
      onDateChanged(picked);
    }
  }
}
