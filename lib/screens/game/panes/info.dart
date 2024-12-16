import 'package:flutter/material.dart';

import 'package:hero/providers/settings.dart';

class InfoPane extends StatelessWidget {
  const InfoPane({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.primaryContainer,
      shadowColor: Theme.of(context).colorScheme.shadow,
      margin: EdgeInsets.all(Settings.gap),
      child: SizedBox.expand(
        child: Center(
            child: Text("INFO",
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onPrimaryContainer))),
      ),
    );
  }
}
