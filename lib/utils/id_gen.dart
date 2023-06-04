part of demoncore;

class ID {
  static final Random _rnd = Random();
  static const _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';

  static String generate(String dcLabel) {
    return "$dcLabel-${List.generate(6, (index) => _chars[_rnd.nextInt(_chars.length)]).join()}";
  }
}
