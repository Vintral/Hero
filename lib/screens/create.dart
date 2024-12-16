import 'package:flutter/material.dart';
import 'package:hero/data/entity.dart';
import 'package:hero/providers/settings.dart';
import 'package:hero/utilities.dart';

import 'package:logger/logger.dart';

import 'package:hero/dictionary.dart';
import 'package:hero/providers/character.dart';

class CreateScreen extends StatefulWidget {
  const CreateScreen({super.key});

  @override
  State<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  final Logger _logger = Logger(level: Level.trace);
  final _character = CharacterProvider();

  final _controller = TextEditingController();
  var _phase = 0;

  @override
  void initState() {
    super.initState();

    _logger.t("initState");

    if (_character.name.isNotEmpty) _phase++;
  }

  initialize() async {
    _logger.t("initialize");
  }

  onNameChanged(String name) {
    _logger.t("onNameChanged: $name");
    _controller.text = name;
  }

  Widget buildContent() {
    var theme = Theme.of(context);

    switch (_phase) {
      case 0:
        return Padding(
          padding: EdgeInsets.all(Settings.gap * 3),
          child: TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: Dictionary.get("NAME"),
            ),
            autofocus: true,
            onChanged: onNameChanged,
            controller: _controller,
          ),
        );
      case 1:
        return Text(
          Dictionary.get("CREATE_SCREEN").toUpperCase(),
          style: Theme.of(context)
              .textTheme
              .bodyLarge
              ?.copyWith(color: theme.colorScheme.onPrimaryContainer),
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

  @override
  Widget build(BuildContext context) {
    _logger.t("build");

    var theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        foregroundColor: theme.colorScheme.onPrimary,
        backgroundColor: theme.colorScheme.primary,
        title: Text(
          capitalizeFirst(getTitle()),
          style: theme.textTheme.titleMedium
              ?.copyWith(color: theme.colorScheme.onPrimary),
        ),
      ),
      body: Stack(
        children: [
          Container(
            color: theme.colorScheme.primaryContainer,
            child: Center(
              child: buildContent(),
            ),
          ),
          Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Padding(
                padding: EdgeInsets.all(Settings.gap * 2),
                child: Row(
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
                          backgroundColor: theme.colorScheme.primary,
                        ),
                        onPressed: () => setState(() {
                          _logger.t("pressed next");
                          _phase++;
                        }),
                        child: Padding(
                          padding: EdgeInsets.all(Settings.gap),
                          child: Text(capitalizeFirst(Dictionary.get("NEXT")),
                              style: theme.textTheme.labelLarge?.copyWith(
                                  color: theme.colorScheme.onPrimary)),
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
