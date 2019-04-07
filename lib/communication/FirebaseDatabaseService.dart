import 'package:cyfrowa_historia_pojazdu/common/generateMd5.dart';
import 'package:cyfrowa_historia_pojazdu/communication/model/CarFix.dart';
import 'package:cyfrowa_historia_pojazdu/communication/model/Demage.dart';
import 'package:cyfrowa_historia_pojazdu/communication/model/car.dart';
import 'package:cyfrowa_historia_pojazdu/communication/model/userdata.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class FirebaseDatabaseService {
  Future<dynamic> addUserToDatabase(UserData userData) async {
    final currentUser = await FirebaseAuth.instance.currentUser();
    final usersReference = FirebaseDatabase.instance
        .reference()
        .child('users')
        .child(currentUser.uid);
    return usersReference.update(userData.toJson());
  }

  Future<dynamic> addCarToUser(Car car) async {
    final currentUser = await FirebaseAuth.instance.currentUser();
    final reference = FirebaseDatabase.instance
        .reference()
        .child('users')
        .child(currentUser.uid)
        .child('cars')
        .child(generateMd5(car.name));
    return reference.update(car.toJson());
  }

  Future<dynamic> removeCar(String carName) async {
    final currentUser = await FirebaseAuth.instance.currentUser();
    final usersReference = FirebaseDatabase.instance
        .reference()
        .child('users')
        .child(currentUser.uid)
        .child('cars')
        .child(generateMd5(carName));
    await usersReference.remove();
    return null;
  }

  Future<dynamic> addFixToCar(CarFix fix, String carName) async {
    final currentUser = await FirebaseAuth.instance.currentUser();
    final usersReference = FirebaseDatabase.instance
        .reference()
        .child('users')
        .child(currentUser.uid)
        .child('cars')
        .child(generateMd5(carName))
        .child("fixes")
        .child(generateMd5(fix.name));
    return usersReference.update(fix.toJson());
  }

  Future<dynamic> removeFixFromCar(String fixName, String carName) async {
    final currentUser = await FirebaseAuth.instance.currentUser();
    final usersReference = FirebaseDatabase.instance
        .reference()
        .child('users')
        .child(currentUser.uid)
        .child('cars')
        .child(generateMd5(carName))
        .child("fixes")
        .child(generateMd5(fixName));
    return usersReference.remove();
  }

  Future<dynamic> addDamageToCar(Damage damage, String carName) async {
    final currentUser = await FirebaseAuth.instance.currentUser();
    final usersReference = FirebaseDatabase.instance
        .reference()
        .child('users')
        .child(currentUser.uid)
        .child('cars')
        .child(generateMd5(carName))
        .child("fixes")
        .child(generateMd5(damage.name));
    return usersReference.update(damage.toJson());
  }

  Future<dynamic> removeDamageFromCar(String damageName, String carName) async {
    final currentUser = await FirebaseAuth.instance.currentUser();
    final usersReference = FirebaseDatabase.instance
        .reference()
        .child('users')
        .child(currentUser.uid)
        .child('cars')
        .child(generateMd5(carName))
        .child("fixes")
        .child(generateMd5(damageName));
    return usersReference.remove();
  }
}
