import 'package:cyfrowa_historia_pojazdu/core/core_page.dart';
import 'package:cyfrowa_historia_pojazdu/ui/SignUp/signup_builder.dart';
import 'package:cyfrowa_historia_pojazdu/ui/SignUp/signup_service.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget implements CorePage<SignupBuilder, SignupService> {
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
        body: widget.builder.buildRootLayout(context, _isLoading, _formKey));
  }
  
}
