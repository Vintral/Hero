import 'package:flutter/material.dart';

import 'package:hero/providers/settings.dart';

class TownPane extends StatelessWidget {
  const TownPane({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.primaryContainer,
      shadowColor: Theme.of(context).colorScheme.shadow,
      margin: EdgeInsets.all(Settings.gap),
      child: SizedBox.expand(
        child: Center(
            child: Text("TOWN",
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onPrimaryContainer))),
      ),
    );
  }
}
