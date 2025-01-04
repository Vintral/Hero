import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

import 'package:hero/data/section.dart';

class Story {
  final Logger _logger = Logger(level: Level.trace);

  String name = "";
  List<Section> sections = [];

  @protected
  int current = 0;

  Section? get section => sections[current];

  Story() {
    _logger.t("Created");
  }

  void onStart() {
    _logger.t("onStart");
  }

  void onFinish() {
    _logger.t("onFinish");
  }

  void build() {
    _logger.f("build - NYI");
  }

  int addSection(Section section) {
    _logger.t("addSection");

    sections.add(section);
    return sections.length - 1;
  }

  void dump() {
    _logger.t("================================");
    _logger.t("Name: $name");
    _logger.t("================================");
  }
}
