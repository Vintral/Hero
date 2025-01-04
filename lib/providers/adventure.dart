import 'package:hero/content/sewer.dart';
import 'package:hero/data/section.dart';
import 'package:hero/data/story.dart';
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

    var d = Story()..name = "Testing";
    d.dump();
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

  Story? _story;

  Section? get section => _story?.section;

  Future<bool> load() async {
    _logger.t("load");

    if (!_loaded) {
      _storage = await SharedPreferences.getInstance();
      _loaded = true;
    }

    _story = Sewer();
    _story!.build();
    _story!.onStart();

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
