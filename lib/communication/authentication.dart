import 'dart:async';

import 'package:cyfrowa_historia_pojazdu/communication/FirebaseDatabaseService.dart';
import 'package:cyfrowa_historia_pojazdu/communication/model/userdata.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserAuth {
  String statusMsg = "Account Created Successfully";

  //To create new User
  Future<String> createUser(UserData userData, String password) async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
        await firebaseAuth.createUserWithEmailAndPassword(
            email: userData.email, password: password)
        .then((firebaseUser) =>
            FirebaseDatabaseService().addUserToDatabase(userData)
            );
    return statusMsg;
  }

  //To verify new User
  Future<dynamic> verifyUser(String email, String password) async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    return firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }
}
