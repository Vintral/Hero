import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:hero/data/player.dart';

class CharacterProvider {
  static final CharacterProvider _instance = CharacterProvider._internal();

  factory CharacterProvider() {
    return _instance;
  }

  CharacterProvider._internal() {
    _logger.f('Created');
  }

  final Logger _logger = Logger();

  bool _loaded = false;
  late SharedPreferences? _storage;

  Player? _player;
  String get name => _player?.name ?? "";
  set name(String value) {
    _player?.name = value;
    _player?.save();
  }

  int get dexterity => _player?.dexterity ?? 0;
  set dexterity(int value) {
    _player?.dexterity = value;
    _player?.save();
  }

  int get faith => _player?.faith ?? 0;
  set faith(int value) {
    _player?.faith = value;
    _player?.save();
  }

  int get fortitude => _player?.fortitude ?? 0;
  set fortitude(int value) {
    _player?.fortitude = value;
    _player?.save();
  }

  int get strength => _player?.strength ?? 0;
  set strength(int value) {
    _player?.strength = value;
    _player?.save();
  }

  int get intellect => _player?.intellect ?? 0;
  set intellect(int value) {
    _player?.intellect = value;
    _player?.save();
  }

  int get willpower => _player?.willpower ?? 0;
  set willpower(int value) {
    _player?.willpower = value;
    _player?.save();
  }

  bool get playing => _player != null;

  Future<bool> load() async {
    _logger.w("load");

    if (!_loaded) {
      _storage = await SharedPreferences.getInstance();
      _loaded = true;
    }

    _player = Player();
    await _player!.load();

    if (_player == null) {
      _logger.f("WE HAVE NO PLAYER");
    } else {
      _logger.f("WE HAVE A PLAYER");
    }

    return true;
  }

  Future<void> clear() async {
    _logger.t("clear");

    await _storage?.remove("name");
  }

  void dump() {
    _player?.dump();
  }
}
