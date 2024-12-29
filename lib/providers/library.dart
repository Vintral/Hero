import 'dart:collection';

import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:hero/data/class.dart';
import 'package:hero/data/race.dart';
import 'package:hero/enums.dart';

class LibraryProvider {
  static final LibraryProvider _instance = LibraryProvider._internal();

  factory LibraryProvider() {
    return _instance;
  }

  LibraryProvider._internal() {
    _logger.t('Created');
  }

  final Logger _logger = Logger();

  bool _loaded = false;
  late SharedPreferences? _storage;

  final Map<ClassType, Class> classes = HashMap();
  final Map<RaceType, Race> races = HashMap();

  Future<bool> load() async {
    _logger.t("load");

    if (!_loaded) {
      _storage = await SharedPreferences.getInstance();
      _loaded = true;
    }

    buildClasses();
    buildRaces();

    return true;
  }

  Future<void> clear() async {
    _logger.t("clear");

    await _storage?.remove("name");
  }

  void buildClasses() {
    _logger.t("buildClasses");

    // [
    //   ClassType.adventurer,
    //   ClassType.cleric,
    //   ClassType.fighter,
    //   ClassType.paladin,
    //   ClassType.thief,
    //   ClassType.wizard
    // ].forEach(
    //   (data) => classes[data] = Class.fromJson({
    //     "name": data.name,
    //     "unlocked": data.name == ClassType.adventurer.name
    //         ? true
    //         : _storage?.getBool("${data.name}Unlocked") ?? false
    //   }),
    // );

    classes[ClassType.fighter] = Class.fromJson({
      "name": ClassType.fighter.name,
      "unlocked": true,
      "stats": {
        Stat.strength.name: 2,
        Stat.fortitude.name: 1,
      }
    });

    classes[ClassType.thief] = Class.fromJson({
      "name": ClassType.thief.name,
      "unlocked": true,
      "stats": {
        Stat.dexterity.name: 3,
      }
    });

    classes[ClassType.cleric] = Class.fromJson({
      "name": ClassType.thief.name,
      "unlocked": true,
      "stats": {
        Stat.faith.name: 2,
        Stat.willpower.name: 1,
      }
    });

    classes[ClassType.wizard] = Class.fromJson({
      "name": ClassType.wizard.name,
      "unlocked": true,
      "stats": {
        Stat.strength.name: -2,
        Stat.fortitude.name: -1,
        Stat.intellect.name: 3,
        Stat.willpower.name: 1,
      }
    });
  }

  void buildRaces() {
    _logger.t("buildRaces");

    races[RaceType.dwarf] = Race.fromJson({
      "name": RaceType.dwarf.name,
      "stats": {Stat.strength.name: 2, Stat.fortitude.name: 2},
      "unlocked": _storage?.getBool("${RaceType.dwarf.name}Unlocked") ?? false,
    });
    races[RaceType.elf] = Race.fromJson({
      "name": RaceType.elf.name,
      "stats": {
        Stat.dexterity.name: 2,
        Stat.willpower.name: 1,
      },
      "unlocked": _storage?.getBool("${RaceType.elf.name}Unlocked") ?? false,
    });
    races[RaceType.fae] = Race.fromJson({
      "name": RaceType.fae.name,
      "stats": {
        Stat.willpower.name: 2,
        Stat.intellect.name: 3,
        Stat.fortitude: -2,
      },
      "unlocked": _storage?.getBool("${RaceType.fae.name}Unlocked") ?? false,
    });
    races[RaceType.giant] = Race.fromJson({
      "name": RaceType.giant.name,
      "stats": {
        Stat.strength.name: 4,
        Stat.intellect.name: -3,
        Stat.dexterity.name: -2,
        Stat.fortitude.name: 1,
      },
      "unlocked": _storage?.getBool("${RaceType.giant.name}Unlocked") ?? false,
    });
    races[RaceType.halfling] = Race.fromJson({
      "name": RaceType.halfling.name,
      "stats": {
        Stat.strength.name: -2,
        Stat.dexterity.name: 4,
        Stat.fortitude: -1,
        Stat.willpower.name: 2
      },
      "unlocked":
          _storage?.getBool("${RaceType.halfling.name}Unlocked") ?? false,
    });
    races[RaceType.human] =
        Race.fromJson({"name": RaceType.human.name, "unlocked": true});
    races[RaceType.lizard] = Race.fromJson({
      "name": RaceType.lizard.name,
      "stats": {Stat.fortitude.name: 4, Stat.strength.name: 1},
      "unlocked": _storage?.getBool("${RaceType.lizard.name}Unlocked") ?? false,
    });
    races[RaceType.troll] = Race.fromJson({
      "name": RaceType.troll.name,
      "stats": {Stat.fortitude.name: 4, Stat.faith.name: 3},
      "unlocked": _storage?.getBool("${RaceType.troll.name}Unlocked") ?? false,
    });
  }

  void dump() {
    _logger.t("=====================================");
    classes.forEach((_, data) => data.dump());
    _logger.t("=====================================");
    races.forEach((_, data) => data.dump());
    _logger.t("=====================================");
  }
}
