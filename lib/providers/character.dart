import 'package:hero/enums.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:hero/data/player.dart';

class CharacterProvider {
  static final CharacterProvider _instance = CharacterProvider._internal();

  factory CharacterProvider() {
    return _instance;
  }

  CharacterProvider._internal() {
    _logger.t('Created');
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

  ClassType get classType => _player?.classType ?? ClassType.none;
  set classType(ClassType value) {
    _player?.classType = value;
    _player?.save();
  }

  RaceType get raceType => _player?.raceType ?? RaceType.none;
  set raceType(RaceType value) {
    _player?.raceType = value;
    _player?.save();
  }

  bool get playing => _player != null;
  bool get active {
    return _player!.name.isNotEmpty &&
        _player!.classType != ClassType.none &&
        _player!.raceType != RaceType.none;
  }

  Future<bool> load() async {
    _logger.t("load");

    if (!_loaded) {
      _storage = await SharedPreferences.getInstance();
      _loaded = true;
    }

    _player = Player();
    await _player!.load();

    return true;
  }

  Future<void> clear() async {
    _logger.t("clear");

    await _storage?.remove("name");
  }

  Future<void> kill() async {
    await _player?.erase();
  }

  void dump() {
    _player?.dump();
  }
}
