import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:hero/data/entity.dart';

class Player extends Entity {
  final Logger _logger = Logger();
  SharedPreferences? _storage;

  Player() {
    _logger.w("Created");
  }

  Future<bool> load() async {
    _logger.w("load");

    _storage ??= await SharedPreferences.getInstance();

    if (_storage != null) {
      name = _storage!.getString("name") ?? "";
      strength = _storage!.getInt("strength") ?? 0;
      dexterity = _storage!.getInt("dexterity") ?? 0;
      fortitude = _storage!.getInt("fortitude") ?? 0;
      faith = _storage!.getInt("faith") ?? 0;
      intellect = _storage!.getInt("intellect") ?? 0;
      willpower = _storage!.getInt("willpower") ?? 0;

      _logger.w("loaded");
      dump();
    } else {
      _logger.f("Storage is null");
    }

    return false;
  }

  Future<bool> save() async {
    _logger.w("save");

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
      ]);

      if (results.every((val) => val)) {
        _logger.w("saved");
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
    _logger.w("================================");
    _logger.w("Name: $name");
    _logger.w("Strength: $strength");
    _logger.w("Dexterity: $dexterity");
    _logger.w("Fortitude: $fortitude");
    _logger.w("Faith: $faith");
    _logger.w("Intellect: $intellect");
    _logger.w("Willpower: $willpower");
    _logger.w("================================");
  }
}
