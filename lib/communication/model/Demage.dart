import 'package:cyfrowa_historia_pojazdu/common/dateTimeFormatter.dart';
import 'package:firebase_database/firebase_database.dart';

class Damage {
  String name;
  String description;
  int course;
  DateTime damageDate;

  Damage(this.name, this.description, this.course, this.damageDate);

  Damage.fromSnapshot(DataSnapshot snapshot) :
        name = snapshot.value["name"],
        description = snapshot.value["description"],
        course = snapshot.value("course"),
        damageDate = stringToDateTime(snapshot.value["damageDate"]);

  toJson() {
    return {
      "name": name,
      "description": description,
      "course": course,
      "damageDate": dateTimeToString(damageDate)
    };
  }
}