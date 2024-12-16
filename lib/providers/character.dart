import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:hero/data/entity.dart';

class CharacterProvider {
  final Logger _logger = Logger();

  bool _loaded = false;
  late SharedPreferences? _storage;

  Entity? _entity;
  String get name => _entity?.name ?? "";
  set name(String value) {
    _storage?.setString("name", value);
  }

  bool get playing => _entity != null;

  Future<bool> load() async {
    _logger.d("load");

    if (!_loaded) {
      _storage = await SharedPreferences.getInstance();
      _loaded = true;
    }

    _entity = Entity();
    _entity!.name = _storage?.getString("name") ?? "";
    _entity!.dump();

    return true;
  }

  Future<void> clear() async {
    _logger.t("clear");

    await _storage?.remove("name");
  }

  void dump() {
    _entity?.dump();
  }
}
