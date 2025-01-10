import 'package:eventify/eventify.dart';
import 'package:logger/logger.dart';

class Entity extends EventEmitter {
  final Logger _logger = Logger();

  String name = "";
  int strength = 0;
  int dexterity = 0;
  int fortitude = 0;
  int faith = 0;
  int intellect = 0;
  int willpower = 0;

  int _health = 0;
  int get health => _health;
  set health(int val) {
    _health = val;
    emit("UPDATED");
  }

  int _healthMax = 0;
  int get healthMax => _healthMax;
  set healthMax(int val) {
    _healthMax = val;
    emit("UPDATED");
  }

  int _resource = 0;
  int get resource => _resource;
  set resource(int val) {
    _resource = val;
    emit("UPDATED");
  }

  int _resourceMax = 0;
  int get resourceMax => _resourceMax;
  set resourceMax(int val) {
    _resourceMax = val;
    emit("UPDATED");
  }

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
    health = data["health"] ?? 1;
    healthMax = data["healthMax"] ?? 1;
    resource = data["resource"] ?? 1;
    resourceMax = data["resourceMax"] ?? 1;
  }

  Map<String, dynamic> toJSON() => {
        "name": name.isEmpty ? "\"\"" : name,
        "strength": strength,
        "dexterity": dexterity,
        "fortitude": fortitude,
        "faith": faith,
        "intellect": intellect,
        "willpower": willpower,
        "health": health,
        "healthMax": healthMax,
        "resource": resource,
        "resourceMax": resourceMax,
      };

  void dump() {
    _logger.t(
      """
================================
Name: $name
Strength: $strength
Dexterity: $dexterity
Fortitude: $fortitude
Faith: $faith
Intellect: $intellect
Willpower: $willpower
Health: $health/$healthMax
Resource: $resource/$resourceMax
================================
      """,
    );
  }
}
