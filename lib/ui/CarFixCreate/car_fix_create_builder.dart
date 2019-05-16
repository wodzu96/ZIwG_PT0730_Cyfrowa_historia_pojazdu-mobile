import 'package:cyfrowa_historia_pojazdu/communication/validations.dart';
import 'package:cyfrowa_historia_pojazdu/core/core_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CarFixCreateBuilder with CoreBuilder, Validations {
  String name;
  String description;
  int course;
  DateTime fixDate;

  Widget buildRootLayout(
      context,
      bool isLoading,
      GlobalKey<FormState> formKey,
      bool formAutoValidate,
      Function onSignupButtonPressed,
      fixDate,
      onDateChanged) {
    if (isLoading)
      return buildLoadingLayout(context);
    else
      return buildDefaultLayout(formKey, formAutoValidate,
          onSignupButtonPressed, context, fixDate, onDateChanged);
  }

  Widget buildDefaultLayout(
      GlobalKey<FormState> formKey,
      bool formAutoValidate,
      Function onSignupButtonPressed,
      BuildContext context,
      DateTime fixDate,
      Function onDateChanged) {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 32.0),
      children: <Widget>[
        SizedBox(height: 32.0),
        buildLoginForm(
            formKey, formAutoValidate, context, fixDate, onDateChanged),
        SizedBox(height: 32.0),
        buildSignupButton(formKey, onSignupButtonPressed)
      ],
    );
  }

  Widget buildLoginForm(GlobalKey<FormState> formKey, bool formAutoValidate,
      BuildContext context, DateTime fixDate, Function onDateChanged) {
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
                  onSaved: (value) => this.description = value,
                  decoration: InputDecoration(
                      hintText: 'Opisz uszkodzenie', labelText: "Opis"))),
          SizedBox(
              height: 80.0,
              child: TextFormField(
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    return validateNumber(value);
                  },
                  onSaved: (value) => this.course = int.parse(value),
                  inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                  decoration: InputDecoration(
                      hintText: 'Podaj aktualny przebieg',
                      labelText: "Przebieg"))),
          SizedBox(
            height: 80.0,
            child: GestureDetector(
              onTap: () => _selectDate(context, fixDate, onDateChanged),
              child: AbsorbPointer(
                child: TextFormField(
                    controller: TextEditingController(
                        text: fixDate.toString().substring(0, 10)),
                    decoration: InputDecoration(
                        hintText: 'Dotknij, aby wybrac datę',
                        labelText: "Data wykonania naprawy")),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildSignupButton(GlobalKey<FormState> formKey, Function onPressed) {
    return SizedBox(
        height: 48.0,
        child: RaisedButton(
          onPressed: () {
            formKey.currentState.save();
            onPressed(this.name, this.description, this.course, this.fixDate);
          },
          color: Colors.blueGrey,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text('Dodaj naprawę', style: TextStyle(color: Colors.white)),
        ));
  }

  Future<Null> _selectDate(
      BuildContext context, DateTime fixDate, Function onDatechanged) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: fixDate,
        firstDate: fixDate.subtract(Duration(days: 365)),
        lastDate: fixDate.add(Duration(days: 365)));

    if (picked != null) {
      this.fixDate = picked;
      onDatechanged(picked);
    }
  }
}
