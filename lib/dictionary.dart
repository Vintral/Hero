class Dictionary {
  static String missing = "/\\/\\1\$\$1Ng";

  static Map<String, String> strings = {
    "CREATE_SCREEN": "create screen",
    "GAME_SCREEN": "game screen",
    "CLASS": "class",
    "NAME": "name",
    "NEXT": "next",
    "PREVIOUS": "previous",
    "RACE": "race",
  };

  static String get(String key) {
    return strings[key] ?? "$missing($key)";
  }
}
