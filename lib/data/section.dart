import 'package:logger/logger.dart';

class Section {
  final Logger _logger = Logger(level: Level.trace);

  String name = "";
  String description = "";

  Section() {
    _logger.t("Created");
  }

  void onEnter() {
    _logger.t("onEnter");
  }

  void onLeave() {
    _logger.t("onLeave");
  }

  void dump() {
    _logger.t("================================");
    _logger.t("Name: $name");
    _logger.t("================================");
  }
}
