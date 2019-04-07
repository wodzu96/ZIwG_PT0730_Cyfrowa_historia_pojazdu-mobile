import 'package:cyfrowa_historia_pojazdu/communication/validations.dart';
import 'package:cyfrowa_historia_pojazdu/core/core_builder.dart';
import 'package:flutter/material.dart';

class SignupBuilder with CoreBuilder, Validations {
  String email;
  String password;
  String passwordRepeat;
  String name;
  String surname;

  Widget buildRootLayout(context, bool isLoading, GlobalKey<FormState> formKey,
      bool formAutoValidate, Function onSignupButtonPressed) {
    if (isLoading)
      return buildLoadingLayout(context);
    else
      return buildDefaultLayout(
          formKey, formAutoValidate, onSignupButtonPressed);
  }

  Widget buildDefaultLayout(GlobalKey<FormState> formKey, bool formAutoValidate,
      Function onSignupButtonPressed) {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 32.0),
      children: <Widget>[
        SizedBox(height: 32.0),
        buildLoginForm(formKey, formAutoValidate),
        SizedBox(height: 32.0),
        buildSignupButton(formKey, onSignupButtonPressed)
      ],
    );
  }

  Widget buildLoginForm(GlobalKey<FormState> formKey, bool formAutoValidate) {
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
                      hintText: 'Podaj imię i nazwisko',
                      labelText: 'Imię i nazwisko'))),
          SizedBox(
              height: 80.0,
              child: TextFormField(
                  validator: (value) {
                    return validateEmail(value);
                  },
                  onSaved: (value) => this.email = value,
                  decoration: InputDecoration(
                      hintText: 'Podaj email', labelText: "Email"))),
          SizedBox(
              height: 80.0,
              child: TextFormField(
                  validator: (value) {
                    return validatePassword(value);
                  },
                  obscureText: true,
                  onSaved: (value) => this.password = value,
                  decoration: InputDecoration(
                      hintText: 'Podaj hasło', labelText: "Hasło"))),
          SizedBox(
              height: 80.0,
              child: TextFormField(
                  validator: (value) {
                    return validatePasswordRepeat(value, this.password);
                  },
                  obscureText: true,
                  onSaved: (value) => this.passwordRepeat = value,
                  decoration: InputDecoration(
                      hintText: 'Powtórz hasło',
                      labelText: "Hasło (powtórzenie)")))
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
            onPressed(this.name, this.email, this.password);
          },
          color: Colors.blueGrey,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text('Utwórz konto', style: TextStyle(color: Colors.white)),
        ));
  }
}
