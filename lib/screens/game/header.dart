import 'dart:async';

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import 'package:hero/providers/character.dart';
import 'package:hero/providers/settings.dart';
import 'package:hero/screens/game/bar.dart';

class Header extends StatefulWidget {
  const Header({super.key});

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  final _logger = Logger(level: Level.info);
  final _character = CharacterProvider();

  @override
  void initState() {
    _character.on("UPDATED", null, onCharacterUpdated);

    addPlayerListeners();

    super.initState();
  }

  @override
  void dispose() {
    _character.clear();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size.width / 4;

    return Container(
      color: Theme.of(context).colorScheme.primary,
      child: !_character.active
          ? SizedBox()
          : Row(
              children: [
                SizedBox(
                  width: size,
                  height: size,
                  child: Stack(
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                          Settings.gap,
                          Settings.gap,
                          Settings.gap,
                          0,
                        ),
                        child: Image.asset("assets/avatars/f_01.png"),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: size * 3,
                  height: size,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: ResourceBar(
                          current: _character.health,
                          max: _character.healthMax,
                        ),
                      ),
                      Expanded(
                        child: ResourceBar(
                          type: ResourceBarType.resource,
                          current: _character.resource,
                          max: _character.resourceMax,
                        ),
                      ),
                      Expanded(
                        child: ResourceBar(
                          type: ResourceBarType.experience,
                          current: _character.experience,
                          max: _character.experienceMax,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  void onCharacterUpdated(e, o) {
    _logger.w("onCharacterUpdated");
  }

  void addPlayerListeners() {
    _logger.t("addPlayerListeners");

    // _character.player?.clear();
    // _character.player?.on("UPDATED", null, onCharacterUpdated);

    // Timer(const Duration(seconds: 2), () => _character.player?.health = 10);
    // Timer(const Duration(seconds: 3), () => _character.player?.resource = 10);
    // Timer(const Duration(seconds: 4), () => _character.player?.experience = 10);
  }
}
