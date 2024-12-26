import 'package:logger/logger.dart';

class Entity {
  final Logger _logger = Logger();

  String name = "";
  int strength = 0;
  int dexterity = 0;
  int fortitude = 0;
  int faith = 0;
  int intellect = 0;
  int willpower = 0;

  Entity() {
    _logger.t("Created");
  }

  Entity.fromJson(Map<String, dynamic> data) {
    name = data["name"] ?? "";

    strength = data["strength"] ?? 1;
    dexterity = data["dexterity"] ?? 1;
    fortitude = data["fortitude"] ?? 1;
    faith = data["faith"] ?? 1;
    intellect = data["intellect"] ?? 1;
    willpower = data["willpower"] ?? 1;
  }

  Map<String, dynamic> toJSON() => {
        "name": name.isEmpty ? "\"\"" : name,
        "strength": strength,
        "dexterity": dexterity,
        "fortitude": fortitude,
        "faith": faith,
        "intellect": intellect,
        "willpower": willpower,
      };

  void dump() {
    _logger.t("================================");
    _logger.t("Name: $name");
    _logger.t("Strength: $strength");
    _logger.t("Dexterity: $dexterity");
    _logger.t("Fortitude: $fortitude");
    _logger.t("Faith: $faith");
    _logger.t("Intellect: $intellect");
    _logger.t("Willpower: $willpower");
    _logger.t("================================");
  }
}
