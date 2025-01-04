import 'package:logger/logger.dart';

import 'package:hero/data/section.dart';
import 'package:hero/data/story.dart';

class Sewer extends Story {
  final _logger = Logger();

  Sewer() : super();

  late int _entrance;

  @override
  void build() {
    _logger.w("build");

    _entrance = addSection(
      Section()
        ..name = "Sewer Entrance"
        ..description = "This is a description",
    );
    current = _entrance;
  }

  @override
  void onStart() {
    super.onStart();

    _logger.f("onStart");
  }
}
