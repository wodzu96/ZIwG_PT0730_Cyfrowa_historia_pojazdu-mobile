import 'package:cyfrowa_historia_pojazdu/common/dateTimeFormatter.dart';
import 'package:firebase_database/firebase_database.dart';

class Car {
  String name;
  String registerNumber;
  String VIN;
  DateTime registerTime;

  Car(this.name, this.registerNumber, this.VIN, this.registerTime);

  Car.fromMap(Map value) :
        name = value["name"],
        registerNumber = value["registerNumber"],
        VIN = value["VIN"],
        registerTime = stringToDateTime(value["registerTime"]);

  toJson() {
    return {
      "name": name,
      "registerNumber": registerNumber,
      "VIN": VIN,
      "registerTime": dateTimeToString(registerTime)
    };
  }
}