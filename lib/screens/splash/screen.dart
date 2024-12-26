import 'package:flutter/material.dart';

import 'package:logger/logger.dart';

import 'package:hero/providers/adventure.dart';
import 'package:hero/providers/character.dart';
import 'package:hero/providers/library.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final Logger _logger = Logger();

  final _character = CharacterProvider();
  final _adventure = AdventureProvider();
  final _library = LibraryProvider();

  @override
  void initState() {
    super.initState();

    _logger.t("initState");

    initialize();
  }

  initialize() async {
    _logger.t("initialize");

    final results = await Future.wait([
      _character.load(),
      _adventure.load(),
      _library.load(),
    ]);

    if (mounted && results.every((val) => val)) {
      if (_character.name.isNotEmpty) {
        Navigator.popAndPushNamed(context, "game");
      } else {
        Navigator.popAndPushNamed(context, "game");
      }
    } else {
      _logger.w("FAILED TO LOAD");
    }

    _library.races.values
        .where((data) => data.unlocked)
        .forEach((data) => data.dump());

    _character.strength = 10;
    _character.dexterity = 5;
  }

  @override
  Widget build(BuildContext context) {
    _logger.t("build");

    return Stack(children: [
      Center(
        child: Text(
          "Splash Screen",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
    ]);
  }
}
