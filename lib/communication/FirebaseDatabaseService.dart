import 'package:cyfrowa_historia_pojazdu/common/generateMd5.dart';
import 'package:cyfrowa_historia_pojazdu/communication/model/CarFix.dart';
import 'package:cyfrowa_historia_pojazdu/communication/model/Demage.dart';
import 'package:cyfrowa_historia_pojazdu/communication/model/Car.dart';
import 'package:cyfrowa_historia_pojazdu/communication/model/userdata.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class FirebaseDatabaseService {
  Future<dynamic> addUserToDatabase(UserData userData) async {
    final currentUser = await FirebaseAuth.instance.currentUser();
    final reference = FirebaseDatabase.instance
        .reference()
        .child('users')
        .child(currentUser.uid);
    return reference.update(userData.toJson());
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
    final reference = FirebaseDatabase.instance
        .reference()
        .child('users')
        .child(currentUser.uid)
        .child('cars')
        .child(generateMd5(carName));
    await reference.remove();
    return null;
  }
  
  Future<Car> getCar(String carName) async {
    final currentUser = await FirebaseAuth.instance.currentUser();
    final reference = FirebaseDatabase.instance
        .reference()
        .child('users')
        .child(currentUser.uid)
        .child('cars')
        .child(generateMd5(carName));
    DataSnapshot snapshot = await reference.once();
    final value = snapshot.value as Map;
    return Car.fromMap(value);
}

  Future<List<Car>> getCars() async {
    final currentUser = await FirebaseAuth.instance.currentUser();
    final reference = FirebaseDatabase.instance
        .reference()
        .child('users')
        .child(currentUser.uid)
        .child('cars');
    DataSnapshot snapshot = await reference.once();
    final value = snapshot.value as Map;
    List<Car> list = [];
    for (final key in value.keys) {
      list.add(Car.fromMap(value[key]));
    }
    return list;
  }

  Future<dynamic> addFixToCar(CarFix fix, String carName) async {
    final currentUser = await FirebaseAuth.instance.currentUser();
    final reference = FirebaseDatabase.instance
        .reference()
        .child('users')
        .child(currentUser.uid)
        .child('cars')
        .child(generateMd5(carName))
        .child("fixes")
        .child(generateMd5(fix.name));
    return reference.update(fix.toJson());
  }

  Future<dynamic> removeFixFromCar(String fixName, String carName) async {
    final currentUser = await FirebaseAuth.instance.currentUser();
    final reference = FirebaseDatabase.instance
        .reference()
        .child('users')
        .child(currentUser.uid)
        .child('cars')
        .child(generateMd5(carName))
        .child("fixes")
        .child(generateMd5(fixName));
    return reference.remove();
  }

  Future<CarFix> getCarFix(String fixName, String carName) async {
    final currentUser = await FirebaseAuth.instance.currentUser();
    final reference = FirebaseDatabase.instance
        .reference()
        .child('users')
        .child(currentUser.uid)
        .child('cars')
        .child(generateMd5(carName))
        .child("fixes")
        .child(generateMd5(fixName));
    DataSnapshot snapshot = await reference.once();
    final value = snapshot.value as Map;
    return CarFix.fromMap(value);
  }

  Future<List<CarFix>> getCarFixes(String carName) async {
    final currentUser = await FirebaseAuth.instance.currentUser();
    final reference = FirebaseDatabase.instance
        .reference()
        .child('users')
        .child(currentUser.uid)
        .child('cars')
        .child(generateMd5(carName))
        .child("fixes");
    DataSnapshot snapshot = await reference.once();
    final value = snapshot.value as Map;
    List<CarFix> list = [];
    for (final key in value.keys) {
      list.add(CarFix.fromMap(value[key]));
    }
    return list;
  }

  Future<dynamic> addDamageToCar(Damage damage, String carName) async {
    final currentUser = await FirebaseAuth.instance.currentUser();
    final reference = FirebaseDatabase.instance
        .reference()
        .child('users')
        .child(currentUser.uid)
        .child('cars')
        .child(generateMd5(carName))
        .child('damages')
        .child(generateMd5(damage.name));
    return reference.update(damage.toJson());
  }

  Future<dynamic> removeDamageFromCar(String damageName, String carName) async {
    final currentUser = await FirebaseAuth.instance.currentUser();
    final reference = FirebaseDatabase.instance
        .reference()
        .child('users')
        .child(currentUser.uid)
        .child('cars')
        .child(generateMd5(carName))
        .child('damages')
        .child(generateMd5(damageName));
    return reference.remove();
  }

  Future<Damage> getCarDamage(String damageName, String carName) async {
    final currentUser = await FirebaseAuth.instance.currentUser();
    final reference = FirebaseDatabase.instance
        .reference()
        .child('users')
        .child(currentUser.uid)
        .child('cars')
        .child(generateMd5(carName))
        .child('damages')
        .child(generateMd5(damageName));
    DataSnapshot snapshot = await reference.once();
    final value = snapshot.value as Map;
    return Damage.fromMap(value);
  }

  Future<List<Damage>> getCarDamages(String carName) async {
    final currentUser = await FirebaseAuth.instance.currentUser();
    final reference = FirebaseDatabase.instance
        .reference()
        .child('users')
        .child(currentUser.uid)
        .child('cars')
        .child(generateMd5(carName))
        .child('damages');
    DataSnapshot snapshot = await reference.once();
    final value = snapshot.value as Map;
    List<Damage> list = [];
    for (final key in value.keys) {
      list.add(Damage.fromMap(value[key]));
    }
    return list;
  }
}
