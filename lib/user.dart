class User {
  static String _name = "C"; //default name

  setName(String name) {
    if (!name.isEmpty) _name = name;
  }

  String getName() {
    return _name;
  }
}
