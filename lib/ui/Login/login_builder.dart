import 'package:cyfrowa_historia_pojazdu/core/core_builder.dart';
import 'package:cyfrowa_historia_pojazdu/communication/validations.dart';
import 'package:flutter/material.dart';

class LoginBuilder with CoreBuilder, Validations {
  String email;
  String password;

  Widget buildRootLayout(context, bool isLoading, GlobalKey<FormState> formKey,
      Function onLoginButtonPressed, Function onSignupButtonPressed) {
    if (isLoading)
      return buildLoadingLayout(context);
    else
      return buildDefaultLayout(
          formKey, onLoginButtonPressed, onSignupButtonPressed);
  }

  Widget buildDefaultLayout(GlobalKey<FormState> formKey,
      Function onLoginButtonPressed, Function onSignupButtonPressed) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        buildLogo(),
        buildLoginForm(formKey),
        buildButtonLayout(formKey, onLoginButtonPressed, onSignupButtonPressed)
      ],
    );
  }

  Widget buildButtonLayout(GlobalKey<FormState> formKey, Function onLoginButtonPressed, Function onSignupButtonPressed) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.0, left: 48, right: 48),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          RaisedButton(
            onPressed: () {
              formKey.currentState.save();
              onLoginButtonPressed(this.email, this.password);
              },
            color: Colors.blueGrey,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            child: Text('Zaloguj się', style: TextStyle(color: Colors.white)),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
          ),
          RaisedButton(
            color: Colors.blueGrey,
            onPressed: onSignupButtonPressed,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            child: Text('Utwórz konto', style: TextStyle(color: Colors.white)),
          )
        ],
      ),
    );
  }

  Widget buildLogo() {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
        child: Image.asset("assets/logo.png"));
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
                    return validateEmail(value);
                  },
                  onSaved: (value) => this.email = value,
                  decoration: InputDecoration(
                      hintText: 'Podaj adres email',
                      labelText: 'Email',
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
                          EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0))))
        ],
      ),
    );
  }
}
