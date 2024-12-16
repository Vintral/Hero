import 'package:logger/logger.dart';

class Entity {
  final Logger _logger = Logger();

  String name = "";

  Entity() {
    _logger.t("Created");
  }

  Entity.fromJson(Map<String, dynamic> data) : name = data["name"] as String;

  Map<String, dynamic> toJSON() => {
        "name": name,
      };

  void dump() {
    _logger.t("================================");
    _logger.t("Name: $name");
    _logger.t("================================");
  }
}
