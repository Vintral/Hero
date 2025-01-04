import 'package:flutter/material.dart';
import 'package:hero/providers/adventure.dart';

import 'package:hero/providers/settings.dart';
import 'package:logger/logger.dart';

class AdventurePane extends StatefulWidget {
  const AdventurePane({super.key});

  @override
  State<AdventurePane> createState() => _AdventurePaneState();
}

class _AdventurePaneState extends State<AdventurePane> {
  final _logger = Logger();

  final _adventure = AdventureProvider();

  Widget getHeader() {
    _logger.t("getHeader");

    var theme = Theme.of(context);

    return Container(
      color: theme.colorScheme.primary,
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: Settings.gap * 2, vertical: Settings.gap),
        child: Text(_adventure.section?.name ?? "---",
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Theme.of(context).colorScheme.onPrimary,
                )),
      ),
    );
  }

  Widget getBody() {
    _logger.t("getBody");

    return Expanded(
      child: Card(
        color: Theme.of(context).colorScheme.primaryContainer,
        child: Text(
          _adventure.section?.description ?? "---",
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
        ),
      ),
    );
  }

  Widget getButtons() {
    _logger.t("getButtons");

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: Settings.gap * 3,
          child: Container(color: Colors.blue),
        ),
        SizedBox(height: Settings.gap / 2),
        SizedBox(
          height: Settings.gap * 3,
          child: Container(color: Colors.green),
        ),
        SizedBox(height: Settings.gap / 2),
        SizedBox(
          height: Settings.gap * 3,
          child: Container(color: Colors.red),
        ),
      ],
    );
  }

  Widget getContent() {
    _logger.t("getContent");

    if (_adventure.section == null) {
      return Center(
          child: Text("No Adventures",
              style: Theme.of(context).textTheme.displaySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onPrimaryContainer)));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        getHeader(),
        getBody(),
        getButtons(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.primaryContainer,
      shadowColor: Theme.of(context).colorScheme.shadow,
      margin: EdgeInsets.all(Settings.gap),
      child: SizedBox.expand(
        child: getContent(),
      ),
    );
  }
}
