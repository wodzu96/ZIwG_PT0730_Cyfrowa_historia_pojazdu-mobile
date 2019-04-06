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
  @override
  Widget build(BuildContext context) {
    return new Scaffold(body:new Center(child: new Text("Sign up"),));
  }
  
}
