import 'package:cyfrowa_historia_pojazdu/common/dateTimeFormatter.dart';

class CarDamage {
  String name;
  String description;
  int course;
  DateTime damageDate;

  CarDamage(this.name, this.description, this.course, this.damageDate);

  CarDamage.fromMap(Map value)
      : name = value["name"],
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
