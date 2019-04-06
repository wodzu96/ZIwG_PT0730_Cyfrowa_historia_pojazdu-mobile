import 'package:cyfrowa_historia_pojazdu/core/core_page.dart';
import 'package:cyfrowa_historia_pojazdu/ui/Login/login_builder.dart';
import 'package:cyfrowa_historia_pojazdu/ui/Login/login_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cyfrowa_historia_pojazdu/services/validations.dart';
import 'package:cyfrowa_historia_pojazdu/services/authentication.dart';
import 'package:progress_hud/progress_hud.dart';

class LoginScreen extends StatefulWidget
    implements CorePage<LoginBuilder, LoginService> {
  const LoginScreen({Key key}) : super(key: key);

  @override
  LoginScreenState createState() => new LoginScreenState();

  @override
  get builder => LoginBuilder();

  @override
  get service => LoginService();
}

class LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      primary: true,
          appBar:  AppBar (
            title: Text("Zaloguj się"),
          ),
        body: widget.builder.buildRootLayout(context, _isLoading, _formKey, _onLoginButtonPressed, _onSignupButtonPressed)
    );
  }

  void _onLoginButtonPressed() {
    if (_formKey.currentState.validate()) {
          setState(() {
            _isLoading = true;
          });
    }
  }

  void _onSignupButtonPressed() {
    Navigator.of(context).pushNamed("/SignUp");
  }
}
