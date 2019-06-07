

class UserData {
  String name;
  String email;

  UserData(this.name, this.email);

  UserData.fromMap(Map value) :
        name = value["name"],
        email = value["email"];

  toJson() {
    return {
      "name": name,
      "email": email,
    };
  }
}