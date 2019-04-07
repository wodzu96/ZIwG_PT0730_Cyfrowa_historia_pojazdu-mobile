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
      Function onSignupButtonPressed) {
    if (isLoading)
      return buildLoadingLayout(context);
    else
      return buildDefaultLayout(formKey, onSignupButtonPressed);
  }

  Widget buildDefaultLayout(
      GlobalKey<FormState> formKey, Function onSignupButtonPressed) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        buildLoginForm(formKey),
        buildSignupButton(formKey, onSignupButtonPressed)
      ],
    );
  }

  Widget buildLoginForm(GlobalKey<FormState> _formKey) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
              child: TextFormField(
                  validator: (value) {
                    return validateName(value);
                  },
                  onSaved: (value) => this.name = value,
                  decoration: InputDecoration(
                      hintText: 'Podaj imię i nazwisko',
                      labelText: 'Imię i nazwisko',
                      contentPadding:
                          EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0)))),
          Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
              child: TextFormField(
                  validator: (value) {
                    return validateEmail(value);
                  },
                  onSaved: (value) => this.email = value,
                  decoration: InputDecoration(
                      hintText: 'Podaj email',
                      labelText: "Email",
                      contentPadding:
                          EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0)))),
          Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
              child: TextFormField(
                  validator: (value) {
                    return validatePassword(value);
                  },
                  obscureText: true,
                  onSaved: (value) => this.password = value,
                  decoration: InputDecoration(
                      hintText: 'Podaj hasło',
                      labelText: "Hasło",
                      contentPadding:
                          EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0)))),
          Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
              child: TextFormField(
                  validator: (value) {
                    return validatePasswordRepeat(value, this.password);
                  },
                  obscureText: true,
                  onSaved: (value) => this.passwordRepeat = value,
                  decoration: InputDecoration(
                      hintText: 'Powtórz hasło',
                      labelText: "Hasło (powtórzenie)",
                      contentPadding:
                          EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0))))
        ],
      ),
    );
  }

  Widget buildSignupButton(GlobalKey<FormState> formKey, Function onPressed) {
    return Padding(
        padding: EdgeInsets.only(top: 16.0, left: 48, right: 48),
        child: RaisedButton(
          onPressed: () {
            formKey.currentState.save();
            onPressed(this.name, this.email, this.password);
          },
          color: Colors.blueGrey,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          child: Text('Utwórz konto', style: TextStyle(color: Colors.white)),
        ));
  }
}
