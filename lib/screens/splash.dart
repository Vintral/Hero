import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hero/providers/character.dart';

import 'package:logger/logger.dart';

import 'package:hero/providers/theme.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final Logger _logger = Logger(level: Level.trace);
  final ThemeProvider _theme = ThemeProvider();
  final CharacterProvider _character = CharacterProvider();

  @override
  void initState() {
    super.initState();

    _logger.t("initState");

    initialize();
  }

  initialize() async {
    _logger.t("initialize");

    var success = await _character.load();

    _logger.t("Character Loaded: $success");

    if (mounted && success) {
      if (_character.name.isNotEmpty) {
        Navigator.popAndPushNamed(context, "game");
      } else {
        Navigator.popAndPushNamed(context, "game");
      }
    }
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
