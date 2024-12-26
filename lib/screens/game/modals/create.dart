import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hero/data/entity.dart';
import 'package:hero/dictionary.dart';
import 'package:hero/enums.dart';
import 'package:hero/providers/character.dart';
import 'package:hero/providers/library.dart';
import 'package:hero/providers/settings.dart';
import 'package:hero/utilities.dart';
import 'package:logger/logger.dart';

class CreateModal extends StatefulWidget {
  const CreateModal({super.key, this.handler});

  final void Function()? handler;

  @override
  State<CreateModal> createState() => _CreateModalState();
}

class _CreateModalState extends State<CreateModal>
    with TickerProviderStateMixin {
  final _logger = Logger(level: Level.warning);
  final _random = Random();

  final _character = CharacterProvider();
  final _library = LibraryProvider();

  final _controller = TextEditingController();
  var _phase = 0;

  late TabController _controllerClass;
  late TabController _controllerRace;

  var _class = ClassType.fighter;
  var _race = RaceType.human;

  final _maxPhase = 2;

  @override
  void dispose() {
    _controllerClass.removeListener(onClassChanged);
    _controllerRace.removeListener(onRaceChanged);

    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _logger.t("initState");

    _controllerClass = TabController(length: 4, vsync: this);
    _controllerRace = TabController(length: 8, vsync: this);

    _controller.text = _character.name;

    if (_character.strength == 0) {
      _character.strength = generateStat();
    }
    if (_character.dexterity == 0) {
      _character.dexterity = generateStat();
    }
    if (_character.fortitude == 0) {
      _character.fortitude = generateStat();
    }
    if (_character.intellect == 0) {
      _character.intellect = generateStat();
    }
    if (_character.faith == 0) {
      _character.faith = generateStat();
    }
    if (_character.willpower == 0) {
      _character.willpower = generateStat();
    }

    if (_character.name.isNotEmpty) _phase++;

    _controllerClass.addListener(onClassChanged);
    _controllerRace.addListener(onRaceChanged);
  }

  onClassChanged() {
    _logger.f("CLASS CHANGED: ${_controllerClass.index}");

    setState(() {
      switch (_controllerClass.index) {
        case 0:
          _class = ClassType.fighter;
        case 1:
          _class = ClassType.thief;
        case 2:
          _class = ClassType.cleric;
        case 3:
          _class = ClassType.wizard;
      }
    });
  }

  onRaceChanged() {
    _logger.f("RACE CHANGED: ${_controllerRace.index}");

    setState(() {
      switch (_controllerRace.index) {
        case 0:
          _race = RaceType.human;
        case 1:
          _race = RaceType.dwarf;
        case 2:
          _race = RaceType.elf;
        case 3:
          _race = RaceType.halfling;
        case 4:
          _race = RaceType.giant;
        case 5:
          _race = RaceType.fae;
        case 6:
          _race = RaceType.lizard;
        case 7:
          _race = RaceType.troll;
      }
    });
  }

  int generateStat() {
    _logger.t("generateStat");

    return _random.nextInt(10) + 5;
  }

  initialize() async {
    _logger.t("initialize");
  }

  onNameChanged(String name) {
    _logger.t("onNameChanged: $name");

    _controller.text = name;
    _character.name = name;
  }

  handleClassTab(int tab) {
    _logger.w("handleClassTab: $tab");
  }

  handleRaceTab(int tab) {
    _logger.w("handleRaceTab: $tab");
  }

  Widget buildContent() {
    switch (_phase) {
      case 0:
        return Padding(
          padding: EdgeInsets.symmetric(
              vertical: Settings.gap, horizontal: Settings.gap),
          child: Card(
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: Dictionary.get("NAME"),
              ),
              autofocus: true,
              onChanged: onNameChanged,
              controller: _controller,
            ),
          ),
        );
      case 1:
        return Column(
          children: [
            Material(
              child: TabBar(
                controller: _controllerClass,
                tabs: [
                  Image.asset("assets/classes/badge_fighter.png"),
                  Image.asset("assets/classes/badge_thief.png"),
                  Image.asset("assets/classes/badge_cleric.png"),
                  Image.asset("assets/classes/badge_wizard.png"),
                ],
                onTap: handleClassTab,
              ),
            ),
            SizedBox(
              height: 300,
              child: TabBarView(
                controller: _controllerClass,
                children: [
                  Container(
                    color: Colors.red,
                    child: Image.asset("assets/classes/fighter.png"),
                  ),
                  Container(
                    color: Colors.green,
                    child: Image.asset("assets/classes/thief.png"),
                  ),
                  Container(
                    color: Colors.yellow,
                    child: Image.asset("assets/classes/cleric.png"),
                  ),
                  Container(
                    color: Colors.blue,
                    child: Image.asset("assets/classes/wizard.png"),
                  ),
                ],
              ),
            ),
          ],
        );
      case 2:
        return SizedBox(
          height: 300,
          child: TabBarView(
            controller: _controllerRace,
            children: [
              Container(
                color: Colors.red,
                child: Image.asset("assets/races/human.png"),
              ),
              Container(
                color: Colors.green,
                child: Image.asset("assets/races/dwarf.png"),
              ),
              Container(
                color: Colors.yellow,
                child: Image.asset("assets/races/elf.png"),
              ),
              Container(
                color: Colors.blue,
                child: Image.asset("assets/races/halfling.png"),
              ),
              Container(
                color: Colors.red,
                child: Image.asset("assets/races/giant.png"),
              ),
              Container(
                color: Colors.green,
                child: Image.asset("assets/races/fae.png"),
              ),
              Container(
                color: Colors.yellow,
                child: Image.asset("assets/races/lizard.png"),
              ),
              Container(
                color: Colors.blue,
                child: Image.asset("assets/races/troll.png"),
              ),
            ],
          ),
        );
    }

    var entity = Entity.fromJson({"name": "Vintral"});
    entity.dump();
    _logger.t(entity.toJSON());

    return Placeholder();
  }

  String getTitle() {
    switch (_phase) {
      case 0:
        return Dictionary.get("NAME");
      case 1:
        return Dictionary.get("RACE");
      case 2:
        return Dictionary.get("CLASS");
      default:
        return Dictionary.missing;
    }
  }

  String getStatAbbreviation(Stat stat) {
    switch (stat) {
      case Stat.strength:
        return "STR";
      case Stat.faith:
        return "FAI";
      case Stat.dexterity:
        return "DEX";
      case Stat.fortitude:
        return "FOR";
      case Stat.intellect:
        return "INT";
      case Stat.willpower:
        return "WIL";
    }
  }

  (int, int) getStat(Stat stat) {
    int val = 0;
    switch (stat) {
      case Stat.strength:
        val = _character.strength;
        break;
      case Stat.faith:
        val = _character.faith;
        break;
      case Stat.dexterity:
        val = _character.dexterity;
        break;
      case Stat.fortitude:
        val = _character.fortitude;
        break;
      case Stat.intellect:
        val = _character.intellect;
        break;
      case Stat.willpower:
        val = _character.willpower;
        break;
    }

    int baseVal = val;

    if (_phase > 0) {
      if (_library.races[_race]?.statBonuses[stat] != null) {
        val += _library.races[_race]?.statBonuses[stat] ?? 0;
      }

      if (_library.classes[_class]?.statBonuses[stat] != null) {
        val += _library.classes[_class]?.statBonuses[stat] ?? 0;
      }
    }

    return (val, baseVal);
  }

  Widget buildStat(Stat stat) {
    _logger.t("buildStat");

    var (curr, base) = getStat(stat);

    var color = curr == base
        ? Theme.of(context).colorScheme.onPrimaryContainer
        : (curr > base ? Colors.green : Colors.red);

    return Center(
      child: Text(
        "${getStatAbbreviation(stat)}: $curr",
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: color),
      ),
    );
  }

  Widget buildStats() {
    _logger.t("buildStats");

    return Container(
      color: Colors.yellow,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: Settings.gap),
        child: GridView.count(
          childAspectRatio: 2.5,
          shrinkWrap: true,
          crossAxisCount: 3,
          primary: false,
          children: [
            buildStat(Stat.strength),
            buildStat(Stat.dexterity),
            buildStat(Stat.fortitude),
            buildStat(Stat.intellect),
            buildStat(Stat.faith),
            buildStat(Stat.willpower),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _logger.t("build");

    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final offset = MediaQuery.of(context).viewInsets.bottom;

    _logger.t("OFFSET: ${MediaQuery.of(context).viewInsets.bottom}");
    _logger.t("MAX SIZE: ${size.height - offset}");

    _logger.w("Class: $_class");

    return Center(
      child: Container(
        // padding: EdgeInsets.symmetric(
        //     vertical: size.height * .1, horizontal: size.width * .1),
        constraints: BoxConstraints(
          // minHeight: (size.height - offset) * .25,
          // minWidth: 0,
          maxWidth: size.width * .9,
          // maxHeight: (size.height - offset) * .9),
          maxHeight: size.height * .9,
        ),
        padding: EdgeInsets.symmetric(
            horizontal: size.width * .1,
            vertical: (size.height - offset) * .05),
        // child: SizedBox(
        //   height: (size.height - offset) * .85,
        child: Container(
          color: theme.colorScheme.primaryContainer,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: Settings.gap,
            children: [
              AppBar(
                foregroundColor: theme.colorScheme.onPrimary,
                backgroundColor: theme.colorScheme.primary,
                title: Text(
                  capitalizeFirst(getTitle()),
                  style: theme.textTheme.titleMedium
                      ?.copyWith(color: theme.colorScheme.onPrimary),
                ),
              ),
              buildStats(),
              buildContent(),
              Padding(
                padding: EdgeInsets.all(Settings.gap),
                child: Row(
                  // child: Padding(
                  //   padding: EdgeInsets.all(Settings.gap * 2),
                  //   child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  spacing: Settings.gap * 2,
                  children: [
                    Expanded(
                      child: TextButton(
                        style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(Settings.gap),
                          ),
                          foregroundColor: theme.colorScheme.onPrimary,
                          backgroundColor: _phase == 0
                              ? theme.colorScheme.inversePrimary
                              : theme.colorScheme.primary,
                        ),
                        onPressed: _phase > 0
                            ? () => setState(() {
                                  _logger.t("pressed previous");
                                  _phase--;
                                })
                            : null,
                        child: Padding(
                          padding: EdgeInsets.all(Settings.gap),
                          child: Text(
                              capitalizeFirst(Dictionary.get("PREVIOUS")),
                              style: theme.textTheme.labelLarge?.copyWith(
                                  color: theme.colorScheme.onPrimary)),
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                        style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(Settings.gap),
                          ),
                          foregroundColor: theme.colorScheme.onPrimary,
                          backgroundColor:
                              (_phase == 0 && _character.name.isEmpty)
                                  ? theme.colorScheme.inversePrimary
                                  : theme.colorScheme.primary,
                        ),
                        onPressed: (_phase == 0 && _character.name.isEmpty)
                            ? null
                            : () => setState(() {
                                  if (_phase == _maxPhase) {
                                    if (widget.handler != null) {
                                      widget.handler!();
                                    }
                                  } else {
                                    _logger.t("pressed next");
                                    _phase++;
                                  }
                                }),
                        child: Padding(
                          padding: EdgeInsets.all(Settings.gap),
                          child: Text(
                              capitalizeFirst(Dictionary.get(
                                  _phase != _maxPhase ? "NEXT" : "CREATE")),
                              style: theme.textTheme.labelLarge?.copyWith(
                                  color: theme.colorScheme.onPrimary)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
