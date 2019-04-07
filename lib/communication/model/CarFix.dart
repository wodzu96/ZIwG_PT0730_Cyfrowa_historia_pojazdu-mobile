import 'package:cyfrowa_historia_pojazdu/common/dateTimeFormatter.dart';
import 'package:firebase_database/firebase_database.dart';

class CarFix {
  String name;
  String description;
  int course;
  String fixCategoryName;
  DateTime fixDate;

  CarFix(this.name, this.description, this.course, this.fixDate, this.fixCategoryName);

  CarFix.fromSnapshot(DataSnapshot snapshot) :
        name = snapshot.value["name"],
        description = snapshot.value["description"],
        course = snapshot.value("course"),
        fixCategoryName = snapshot.value["fixCategoryName"],
        fixDate = stringToDateTime(snapshot.value["fixDate"]);

  toJson() {
    return {
      "name": name,
      "description": description,
      "course": course,
      "fixCategoryName": fixCategoryName,
      "DateTime": dateTimeToString(fixDate)
    };
  }
}