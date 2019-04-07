import 'package:cyfrowa_historia_pojazdu/common/dateTimeFormatter.dart';
import 'package:firebase_database/firebase_database.dart';

class CarFix {
  String name;
  String description;
  int course;
  String fixCategoryName;
  DateTime fixDate;

  CarFix(this.name, this.description, this.course, this.fixDate, this.fixCategoryName);

  CarFix.fromMap(Map value) :
        name = value["name"],
        description = value["description"],
        course = value["course"],
        fixCategoryName = value["fixCategoryName"],
        fixDate = stringToDateTime(value["fixDate"]);

  toJson() {
    return {
      "name": name,
      "description": description,
      "course": course,
      "fixCategoryName": fixCategoryName,
      "fixDate": dateTimeToString(fixDate)
    };
  }
}