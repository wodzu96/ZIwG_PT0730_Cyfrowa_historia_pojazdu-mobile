import 'package:cyfrowa_historia_pojazdu/core/core_page.dart';
import 'package:cyfrowa_historia_pojazdu/ui/Login/login_builder.dart';
import 'package:cyfrowa_historia_pojazdu/ui/Login/login_service.dart';
import 'package:flutter/material.dart';
import 'package:cyfrowa_historia_pojazdu/communication/validations.dart';

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
        appBar: AppBar(
          title: Text("Zaloguj się"),
        ),
        body: widget.builder.buildRootLayout(context, _isLoading, _formKey,
            _onLoginButtonPressed, _onSignupButtonPressed));
  }

  void _onLoginButtonPressed(String email, String password) {
    if (_formKey.currentState.validate()) {
      _performLogin(email, password);
    }
  }

  void _onSignupButtonPressed() {
    Navigator.of(context).pushNamed("/SignUp");
  }

  void _performLogin(String email, String password) {
            setState(() {
        _isLoading = true;
      });

      widget.service.verifyUser(email, password)
      .then((value) {
        setState(() {
          _isLoading = false;
        });
        debugPrint(value);
      }).catchError((error) {
        setState(() {
          _isLoading = false;
        });
        debugPrint(error);
      });
  }
}
