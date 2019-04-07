import 'package:cyfrowa_historia_pojazdu/common/dateTimeFormatter.dart';
import 'package:firebase_database/firebase_database.dart';

class Car {
  String name;
  String registerNumber;
  String VIN;
  DateTime registerTime;

  Car(this.name, this.registerNumber, this.VIN, this.registerTime);

  Car.fromSnapshot(DataSnapshot snapshot) :
        name = snapshot.value["name"],
        registerNumber = snapshot.value["registerNumber"],
        VIN = snapshot.value("VIN"),
        registerTime = stringToDateTime(snapshot.value["registerTime"]);

  toJson() {
    return {
      "name": name,
      "registerNumber": registerNumber,
      "VIN": VIN,
      "registerTime": dateTimeToString(registerTime)
    };
  }
}