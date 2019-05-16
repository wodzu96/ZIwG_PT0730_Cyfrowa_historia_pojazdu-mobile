class Validations {
  String validateName(String value) {
    if (value.isEmpty) return 'Wymagane';
    return null;
  }

  String validateEmail(String value) {
    if (value.isEmpty) return 'Wymagane';
    final RegExp nameExp = new RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
    if (!nameExp.hasMatch(value)) return 'Niepoprawny adres e-mail';
    return null;
  }

  String validatePassword(String value) {
    if (value.isEmpty) return 'Wymagane';
    if (value.length < 8) return 'Hasło musi mieć 8 lub więcej znaków';
    return null;
  }

  String validatePasswordRepeat(String value, String password) {
    if (value.isEmpty) return 'Wymagane';
    if (value != password) return 'Hasła nie są takie same';
    return null;
  }

  String validateEmpty(String value) {
    if (value.isEmpty) return 'Wymagane';
    return null;
  }
}
