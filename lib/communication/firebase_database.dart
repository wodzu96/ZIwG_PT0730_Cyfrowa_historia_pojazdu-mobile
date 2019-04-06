import 'package:cyfrowa_historia_pojazdu/common/generateMd5.dart';
import 'package:cyfrowa_historia_pojazdu/communication/model/userdata.dart';
import 'package:firebase_database/firebase_database.dart';

class FirebaseDatabaseService {
  Future<dynamic> addUserToDatabase(UserData userData) async {
    final usersReference = FirebaseDatabase.instance
        .reference()
        .child('usersdata')
        .child(generateMd5(userData.email));
    await usersReference.update(userData.toJson());
    return "OK";
  }
}
