import 'package:cyfrowa_historia_pojazdu/core/core_builder.dart';
import 'package:cyfrowa_historia_pojazdu/communication/validations.dart';
import 'package:flutter/material.dart';

class SignupBuilder with CoreBuilder, Validations {
  String email;
  String password;
  String passwordRepeat;
  String name;
  String surname;

  Widget buildRootLayout(
      context, bool isLoading, GlobalKey<FormState> formKey) {
    if (isLoading)
      return buildLoadingLayout(context);
    else
      return buildDefaultLayout(formKey);
  }

  Widget buildDefaultLayout(GlobalKey<FormState> formKey) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        buildLoginForm(formKey),
        buildSignupButton(formKey)
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
                      hintText: 'Podaj imię',
                      labelText: 'Imię',
                      contentPadding:
                          EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0)))),
          Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
              child: TextFormField(
                  validator: (value) {
                    return validateName(value);
                  },
                  onSaved: (value) => this.surname = value,
                  decoration: InputDecoration(
                      hintText: 'Podaj nazwisko',
                      labelText: "Nazwisko",
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
                    return validatePassword(value);
                  },
                  obscureText: true,
                  onSaved: (value) => this.passwordRepeat = value,
                  decoration: InputDecoration(
                      hintText: 'Powtórz hasło',
                      labelText: "Hasło",
                      contentPadding:
                          EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0))))
        ],
      ),
    );
  }

    Widget buildSignupButton(GlobalKey<FormState> formKey) {
    return Padding(
      padding: EdgeInsets.only(top: 16.0, left: 48, right: 48),
      child: RaisedButton(
            onPressed: () {
              formKey.currentState.save();
              },
            color: Colors.blueGrey,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            child: Text('Utwórz konto', style: TextStyle(color: Colors.white)),
          ));
  }
}
