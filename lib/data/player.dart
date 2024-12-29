import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:hero/data/entity.dart';
import 'package:hero/enums.dart';

class Player extends Entity {
  final Logger _logger = Logger();
  SharedPreferences? _storage;

  ClassType classType = ClassType.none;
  RaceType raceType = RaceType.none;

  Player() {
    _logger.t("Created");
  }

  ClassType loadClassType() {
    _logger.t("loadClassType ${_storage!.getString("class")}");

    switch (_storage!.getString("class")) {
      case "fighter":
        return ClassType.fighter;
      case "thief":
        return ClassType.thief;
      case "cleric":
        return ClassType.cleric;
      case "wizard":
        return ClassType.wizard;
    }

    return ClassType.none;
  }

  RaceType loadRaceType() {
    _logger.t("loadRaceType: ${_storage!.getString("race")}");

    switch (_storage!.getString("race")) {
      case "dwarfv":
        return RaceType.dwarf;
      case "elf":
        return RaceType.elf;
      case "fae":
        return RaceType.fae;
      case "giant":
        return RaceType.giant;
      case "halfling":
        return RaceType.halfling;
      case "human":
        return RaceType.human;
      case "lizard":
        return RaceType.lizard;
      case "troll":
        return RaceType.troll;
    }

    return RaceType.none;
  }

  Future<bool> load() async {
    _logger.t("load");

    _storage ??= await SharedPreferences.getInstance();

    if (_storage != null) {
      name = _storage!.getString("name") ?? "";
      strength = _storage!.getInt("strength") ?? 0;
      dexterity = _storage!.getInt("dexterity") ?? 0;
      fortitude = _storage!.getInt("fortitude") ?? 0;
      faith = _storage!.getInt("faith") ?? 0;
      intellect = _storage!.getInt("intellect") ?? 0;
      willpower = _storage!.getInt("willpower") ?? 0;
      classType = loadClassType();
      raceType = loadRaceType();

      dump();

      return true;
    } else {
      _logger.f("Storage is null");
    }

    return false;
  }

  Future<bool> erase() async {
    _logger.t("erase");

    _storage ??= await SharedPreferences.getInstance();

    if (_storage != null) {
      final results = await Future.wait([
        _storage!.remove("name"),
        _storage!.remove("strength"),
        _storage!.remove("dexterity"),
        _storage!.remove("fortitude"),
        _storage!.remove("faith"),
        _storage!.remove("intellect"),
        _storage!.remove("willpower"),
        _storage!.remove("race"),
        _storage!.remove("class"),
      ]);

      if (results.every((val) => val)) {
        return await load();
      } else {
        _logger.w("FAILED TO KILL");
      }
    } else {
      _logger.f("Storage is null");
    }

    return false;
  }

  Future<bool> save() async {
    _logger.t("save");

    _storage ??= await SharedPreferences.getInstance();

    if (_storage != null) {
      final results = await Future.wait([
        _storage!.setString("name", name),
        _storage!.setInt("strength", strength),
        _storage!.setInt("dexterity", dexterity),
        _storage!.setInt("fortitude", fortitude),
        _storage!.setInt("faith", faith),
        _storage!.setInt("intellect", intellect),
        _storage!.setInt("willpower", willpower),
        _storage!.setString("race", raceType.name),
        _storage!.setString("class", classType.name),
      ]);

      if (results.every((val) => val)) {
        return true;
      } else {
        _logger.w("Error saving player");
      }
    } else {
      _logger.w("No Storage");
    }

    return false;
  }

  @override
  void dump() {
    _logger.t("================================");
    _logger.t("Name: $name");
    _logger.t("Strength: $strength");
    _logger.t("Dexterity: $dexterity");
    _logger.t("Fortitude: $fortitude");
    _logger.t("Faith: $faith");
    _logger.t("Intellect: $intellect");
    _logger.t("Willpower: $willpower");
    _logger.t("Class: $classType");
    _logger.t("Race: $raceType");
    _logger.t("================================");
  }
}
