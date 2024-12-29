import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:logger/logger.dart';

import 'package:hero/dictionary.dart';
import 'package:hero/providers/character.dart';
import 'package:hero/screens/game/header.dart';
import 'package:hero/screens/game/modals/create.dart';
import 'package:hero/screens/game/panes/achievement.dart';
import 'package:hero/screens/game/panes/adventure.dart';
import 'package:hero/screens/game/panes/info.dart';
import 'package:hero/screens/game/panes/town.dart';
import 'package:hero/utilities.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final Logger _logger = Logger(level: Level.info);
  final _character = CharacterProvider();

  int _page = 0;
  Widget? modal;

  @override
  void initState() {
    if (!_character.active) {
      modal = CreateModal(
        handler: onCloseModal,
      );
    }

    super.initState();
  }

  onCloseModal() {
    _logger.i("onCloseModal");

    setState(() {
      modal = null;
    });
  }

  Widget getButtonLabel(String label) {
    var theme = Theme.of(context);

    return Text(
      label,
      style: theme.textTheme.bodyLarge
          ?.copyWith(color: theme.colorScheme.onPrimary),
    );
  }

  List<Widget?> getButtons() {
    _logger.t("getButtons");

    final theme = Theme.of(context);

    return [
      FloatingActionButton.extended(
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: theme.colorScheme.onPrimary,
        onPressed: onKillCharacter,
        icon: Icon(Icons.add),
        label: getButtonLabel(
          capitalizeFirst(
            Dictionary.get("KILL"),
          ),
        ),
      ),
      null,
      null,
      null,
    ];
  }

  // Future<void> onCreateCharacter() {
  Future<void> onKillCharacter() async {
    _logger.t("onKillCharacter");

    await _character.kill();

    setState(() {
      modal = CreateModal(
        handler: onCloseModal,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    _logger.t("build");

    return SafeArea(
      child: Stack(children: [
        Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(_character.playing
                ? MediaQuery.of(context).size.height / 8
                : 0),
            child: Header(),
          ),
          floatingActionButton: getButtons()[_page],
          bottomNavigationBar: NavigationBar(
            backgroundColor: Theme.of(context).colorScheme.primary,
            indicatorColor: Theme.of(context).colorScheme.primaryContainer,
            onDestinationSelected: (value) => setState(() {
              _page = value;
            }),
            selectedIndex: _page,
            destinations: [
              NavigationDestination(
                icon: Icon(Icons.airplanemode_active),
                label: Dictionary.get("ADVENTURE"),
              ),
              NavigationDestination(
                icon: Icon(Icons.location_city),
                label: Dictionary.get("TOWN"),
              ),
              NavigationDestination(
                icon: Icon(Icons.badge),
                label: Dictionary.get("ACHIEVEMENTS"),
              ),
              NavigationDestination(
                icon: Icon(Icons.local_library),
                label: Dictionary.get("INFO"),
              ),
            ],
          ),
          body: [
            AdventurePane(),
            TownPane(),
            AchievementPane(),
            InfoPane(),
          ][_page],
        ),
        if (modal != null) ...[
          BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 5,
              sigmaY: 5,
            ),
            child: ModalBarrier(
              dismissible: true,
              color: Colors.black.withAlpha(150),
            ),
          ),
          // Center(
          //   child: modal,
          // ),
          modal as Widget,
        ]
      ]),
    );
  }
}
