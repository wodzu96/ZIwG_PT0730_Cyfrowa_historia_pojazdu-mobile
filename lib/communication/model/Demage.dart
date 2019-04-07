import 'package:cyfrowa_historia_pojazdu/common/dateTimeFormatter.dart';
import 'package:firebase_database/firebase_database.dart';

class Damage {
  String name;
  String description;
  int course;
  DateTime damageDate;

  Damage(this.name, this.description, this.course, this.damageDate);

  Damage.fromMap(Map value) :
        name = value["name"],
        description = value["description"],
        course = value["course"],
        damageDate = stringToDateTime(value["damageDate"]);

  toJson() {
    return {
      "name": name,
      "description": description,
      "course": course,
      "damageDate": dateTimeToString(damageDate)
    };
  }
}