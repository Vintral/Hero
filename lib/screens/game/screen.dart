import 'package:flutter/material.dart';

import 'package:logger/logger.dart';

import 'package:hero/dictionary.dart';
import 'package:hero/providers/character.dart';
import 'package:hero/screens/game/header.dart';
import 'package:hero/screens/game/panes/achievement.dart';
import 'package:hero/screens/game/panes/adventure.dart';
import 'package:hero/screens/game/panes/info.dart';
import 'package:hero/screens/game/panes/town.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final Logger _logger = Logger();
  final _character = CharacterProvider();

  int _page = 0;

  @override
  Widget build(BuildContext context) {
    _logger.t("build");

    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(
              _character.playing ? MediaQuery.of(context).size.height / 8 : 0),
          child: Header(),
        ),
        bottomNavigationBar: NavigationBar(
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
    );
  }
}
