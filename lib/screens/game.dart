import 'package:flutter/material.dart';
import 'package:hero/dictionary.dart';

import 'package:logger/logger.dart';

import 'package:hero/providers/theme.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final Logger _logger = Logger();
  final ThemeProvider _theme = ThemeProvider();

  @override
  void initState() {
    super.initState();

    _logger.t("initState");
  }

  initialize() async {
    _logger.t("initialize");
  }

  @override
  Widget build(BuildContext context) {
    _logger.t("build");

    var theme = Theme.of(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(150),
        child: Container(
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      body: Container(
        color: Theme.of(context).colorScheme.primaryContainer,
        child: Center(
          child: Text(
            Dictionary.get("GAME_SCREEN"),
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(color: theme.colorScheme.onPrimaryContainer),
          ),
        ),
      ),
    );
  }
}
