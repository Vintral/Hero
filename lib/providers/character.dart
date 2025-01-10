import 'package:eventify/eventify.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:hero/data/entity.dart';
import 'package:hero/enums.dart';

class CharacterProvider extends Entity implements EventEmitter {
  static final CharacterProvider _instance = CharacterProvider._internal();

  factory CharacterProvider() {
    return _instance;
  }

  CharacterProvider._internal() {
    _logger.t('Created');
  }

  final Logger _logger = Logger();

  SharedPreferences? _storage;

  ClassType classType = ClassType.none;
  RaceType raceType = RaceType.none;

  bool _active = false;
  bool get active => _active;
  set active(bool value) {
    _active = value;
    emit("UPDATED");
  }

  int _experience = 0;
  int get experience => _experience;
  set experience(int val) {
    _experience = val;
    emit("UPDATED");
  }

  int _experienceMax = 0;
  int get experienceMax => _experienceMax;
  set experienceMax(int val) {
    _experienceMax = val;
    emit("UPDATED");
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
      health = _storage!.getInt("health") ?? 1;
      healthMax = _storage!.getInt("healthMax") ?? 1;
      resource = _storage!.getInt("resource") ?? 1;
      resourceMax = _storage!.getInt("resourceMax") ?? 1;
      experience = _storage!.getInt("experience") ?? 1;
      experienceMax = _storage!.getInt("experienceMax") ?? 1;
      active = _storage!.getBool("active") ?? false;
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
        _storage!.remove("health"),
        _storage!.remove("healthMax"),
        _storage!.remove("resource"),
        _storage!.remove("resourceMax"),
        _storage!.remove("experience"),
        _storage!.remove("experienceMax"),
        _storage!.remove("race"),
        _storage!.remove("class"),
        _storage!.remove("active"),
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
        _storage!.setInt("health", health),
        _storage!.setInt("healthMax", healthMax),
        _storage!.setInt("resource", resource),
        _storage!.setInt("resourceMax", resourceMax),
        _storage!.setInt("experience", experience),
        _storage!.setInt("experienceMax", experienceMax),
        _storage!.setString("race", raceType.name),
        _storage!.setString("class", classType.name),
        _storage!.setBool("active", active),
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

  @override
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
Class: $classType
Race: $raceType
Health: $health/$healthMax
Resource: $resource/$resourceMax
Experience: $experience/$experienceMax
Active: $active
================================
      """,
    );
  }
}
