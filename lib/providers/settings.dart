import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings {
  static String version = "0.0.1";
  final Logger _logger = Logger(level: Logger.level);

  bool _loaded = false;
  late SharedPreferences? settings;

  static int gap = 10;

  Future<bool> load() async {
    _logger.d("load");

    if (!_loaded) {
      settings = await SharedPreferences.getInstance();
      _loaded = true;
    } else {
      settings?.reload();
    }

    // Settings.AutomaticLogin = settings.getBool( "automatic_login" ) ?? false;
    // Settings.Username = settings.getString( "username" ) ?? "";
    // Settings.Password = settings.getString( "password" ) ?? "";

    dump();

    return true;
  }

  void dump() {
    _logger.t("================================");
    _logger.t("Version: ${version}");
    _logger.t("================================");
  }
}
