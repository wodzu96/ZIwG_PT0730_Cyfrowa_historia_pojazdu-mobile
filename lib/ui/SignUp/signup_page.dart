import 'package:cyfrowa_historia_pojazdu/communication/model/userdata.dart';
import 'package:cyfrowa_historia_pojazdu/core/core_page.dart';
import 'package:cyfrowa_historia_pojazdu/ui/SignUp/signup_builder.dart';
import 'package:cyfrowa_historia_pojazdu/ui/SignUp/signup_service.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget
    implements CorePage<SignupBuilder, SignupService> {
  const SignUpScreen({Key key}) : super(key: key);

  @override
  SignUpScreenState createState() => new SignUpScreenState();

  @override
  get builder => SignupBuilder();

  @override
  get service => SignupService();
}

class SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        primary: true,
        appBar: AppBar(
          title: Text("Utwórz konto"),
        ),
        body: widget.builder.buildRootLayout(
            context, _isLoading, _formKey, _onSignupButtonPressed));
  }

  void _onSignupButtonPressed(String name, String email, String password) {
    if (_formKey.currentState.validate()) {
      _performSignup(UserData(name, email), password);
    }
  }

  void _performSignup(UserData userData, String password) {
    _setStateLoading(true);
    widget.service
        .createUser(userData, password)
        .then((value) => _onSignupSuccess())
        .catchError((dynamic error) => _onSignupError(error));
  }

  void _onSignupError(dynamic error) {
    _setStateLoading(false);
    widget.builder.showErrorDialog(
        context,
        "Nie udało się utworzyć konta. Podany adres e-mail jest już zajęty.",
        () {});
    print(error.details);
  }

  void _onSignupSuccess() {
    _setStateLoading(false);
    widget.builder.showSuccessDialog(context,
        "Konto zostało pomyślnie utworzone. Moesz teraz zalogować się do serwisu.",
        () {
      Navigator.of(context).pop();
    });
  }

  void _setStateLoading(bool isLoading) {
    setState(() {
      _isLoading = isLoading;
    });
  }
}
