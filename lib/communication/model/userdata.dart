import 'package:firebase_database/firebase_database.dart';

class UserData {
  String name;
  String email;

  UserData(this.name, this.email);

  UserData.fromSnapshot(DataSnapshot snapshot) :
        name = snapshot.value["name"],
        email = snapshot.value["email"];

  toJson() {
    return {
      "name": name,
      "email": email,
    };
  }
}