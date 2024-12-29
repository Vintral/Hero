import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:hero/data/entity.dart';

class AdventureProvider {
  static final AdventureProvider _instance = AdventureProvider._internal();

  factory AdventureProvider() {
    return _instance;
  }

  AdventureProvider._internal() {
    _logger.t('Created');
  }

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
    _logger.t("load");

    if (!_loaded) {
      _storage = await SharedPreferences.getInstance();
      _loaded = true;
    }

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
