class Dictionary {
  static String missing = "/\\/\\1\$\$1Ng";

  static Map<String, String> strings = {
    "ADVENTURE": "adventure",
    "CLASS": "class",
    "TOWN": "town",
    "ACHIEVEMENTS": "achievements",
    "CREATE": "create",
    "INFO": "info",
    "KILL": "kill",
    "NAME": "name",
    "NEXT": "next",
    "PREVIOUS": "previous",
    "RACE": "race",
    "START": "start",
  };

  static String get(String key) {
    return strings[key] ?? "$missing($key)";
  }
}
