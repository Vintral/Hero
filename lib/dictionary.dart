class Dictionary {
  static String missing = "/\\/\\1\$\$1Ng";

  static Map<String, String> strings = {
    "ADVENTURE": "adventure",
    "CLASS": "class",
    "TOWN": "town",
    "ACHIEVEMENTS": "achievements",
    "INFO": "info",
    "NAME": "name",
    "NEXT": "next",
    "PREVIOUS": "previous",
    "RACE": "race",
  };

  static String get(String key) {
    return strings[key] ?? "$missing($key)";
  }
}
