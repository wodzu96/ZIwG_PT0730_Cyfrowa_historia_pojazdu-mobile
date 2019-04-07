import 'package:cyfrowa_historia_pojazdu/core/core_page.dart';
import 'package:cyfrowa_historia_pojazdu/ui/Login/login_builder.dart';
import 'package:cyfrowa_historia_pojazdu/ui/Login/login_service.dart';
import 'package:flutter/material.dart';

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
  bool _formAutoValidate = false;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        primary: true,
        appBar: AppBar(
          title: Text("Zaloguj się"),
        ),
        body: SafeArea(
            child: widget.builder.buildRootLayout(
                context,
                _isLoading,
                _formKey,
                _formAutoValidate,
                _onLoginButtonPressed,
                _onSignupButtonPressed)));
  }

  void _onLoginButtonPressed(String email, String password) {
    if (_formKey.currentState.validate()) {
      _performLogin(email, password);
    } else {
      _setStateAutoValidateForm(true);
    }
  }

  void _onSignupButtonPressed() {
    Navigator.of(context).pushNamed("/SignUp");
  }

  void _performLogin(String email, String password) {
    _setStateLoading(true);
    widget.service
        .verifyUser(email, password)
        .then((value) => _onLoginSuccess())
        .catchError((dynamic error) => _onLoginError(error));
  }

  void _onLoginError(dynamic error) {
    _setStateLoading(false);
    widget.builder.showErrorDialog(
        context,
        "Nie udało się zalogować. Dane logowania są niepoprawne, lub podany adres e-mail nie jest przypisany do istniejącego konta.",
        () {});
    print(error.details);
  }

  void _onLoginSuccess() {
    _setStateLoading(false);
    Navigator.of(context).pushNamed("/HomePage");
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
