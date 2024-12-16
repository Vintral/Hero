import 'package:logger/logger.dart';

class ThemeProvider {
  static final ThemeProvider _instance = ThemeProvider._internal();

  factory ThemeProvider() {
    return _instance;
  }

  final Logger _logger = Logger();

  ThemeProvider._internal() {
    _logger.d('Created');
  }
}
