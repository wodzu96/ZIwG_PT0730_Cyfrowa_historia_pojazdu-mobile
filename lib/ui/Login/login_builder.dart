import 'package:cyfrowa_historia_pojazdu/communication/validations.dart';
import 'package:cyfrowa_historia_pojazdu/core/core_builder.dart';
import 'package:flutter/material.dart';

class LoginBuilder with CoreBuilder, Validations {
  String email;
  String password;

  Widget buildRootLayout(context,
      bool isLoading,
      GlobalKey<FormState> formKey,
      bool autoValidateForm,
      Function onLoginButtonPressed,
      Function onSignupButtonPressed) {
    if (isLoading)
      return buildLoadingLayout(context);
    else
      return buildDefaultLayout(formKey, autoValidateForm, onLoginButtonPressed,
          onSignupButtonPressed);
  }

  Widget buildDefaultLayout(GlobalKey<FormState> formKey, bool autoValidateForm,
      Function onLoginButtonPressed, Function onSignupButtonPressed) {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 32.0),
      children: <Widget>[
        SizedBox(height: 32.0),
        buildLogo(),
        SizedBox(height: 32.0),
        buildLoginForm(formKey, autoValidateForm),
        SizedBox(height: 32.0),
        buildButtonLayout(formKey, onLoginButtonPressed, onSignupButtonPressed)
      ],
    );
  }

  Widget buildButtonLayout(GlobalKey<FormState> formKey,
      Function onLoginButtonPressed, Function onSignupButtonPressed) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        SizedBox(
            height: 48.0,
            child: RaisedButton(
              onPressed: () {
                formKey.currentState.save();
                onLoginButtonPressed(this.email, this.password);
              },
              color: Colors.blueGrey,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text('Zaloguj się', style: TextStyle(color: Colors.white)),
            )),
        SizedBox(height: 32.0),
        SizedBox(
          height: 48.0,
          child: RaisedButton(
            color: Colors.blueGrey,
            onPressed: onSignupButtonPressed,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text('Utwórz konto', style: TextStyle(color: Colors.white)),
          ),
        )
      ],
    );
  }

  Widget buildLogo() {
    return Image.asset("assets/logo.png");
  }

  Widget buildLoginForm(GlobalKey<FormState> formKey, bool autoValidateForm) {
    return Form(
      key: formKey,
      autovalidate: autoValidateForm,
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 80.0,
            child: buildEmailFormField(),
          ),
          SizedBox(
            height: 80.0,
            child: buildPasswordFormField(),
          )
        ],
      ),
    );
  }

  Widget buildEmailFormField() {
    return TextFormField(
        validator: (value) {
          return validateEmail(value);
        },
        onSaved: (value) => this.email = value,
        decoration:
        InputDecoration(hintText: 'Podaj adres email', labelText: 'Email'));
  }

  Widget buildPasswordFormField() {
    return TextFormField(
        validator: (value) {
          return validatePassword(value);
        },
        obscureText: true,
        onSaved: (value) => this.password = value,
        decoration:
        InputDecoration(hintText: 'Podaj hasło', labelText: "Hasło"));
  }
}
