import 'dart:collection';

import 'package:logger/logger.dart';

import 'package:hero/enums.dart';

class Class {
  final Logger _logger = Logger(level: Level.trace);

  String name = "";
  Map<Stat, int> statBonuses = HashMap();
  bool unlocked = false;

  Class() {
    _logger.t("Created");
  }

  Class.fromJson(Map<String, dynamic> data) {
    name = data["name"] as String;
    if (data["stats"] != null) {
      if (data["stats"] is Map<String, int>) {
        var stats = data["stats"] as Map<String, int>;
        stats.forEach((stat, val) => switch (stat) {
              "strength" => statBonuses[Stat.strength] = val,
              "dexterity" => statBonuses[Stat.dexterity] = val,
              "fortitude" => statBonuses[Stat.fortitude] = val,
              "faith" => statBonuses[Stat.faith] = val,
              "intellect" => statBonuses[Stat.intellect] = val,
              "willpower" => statBonuses[Stat.willpower] = val,
              String() => _logger.w("Unexpected stat: $stat"),
            });
      }
    }

    unlocked = data["unlocked"] ?? false;
  }

  Map<String, dynamic> toJSON() => {
        "name": name,
      };

  void dump() {
    var stats = "";
    statBonuses.forEach((stat, val) =>
        stats += "${(stats.isNotEmpty ? ", " : "")} ${stat.name}:$val");

    _logger.t(
      """
================================
Name: $name
Stats: [$stats]
Unlocked: $unlocked
================================
      """,
    );
  }
}
