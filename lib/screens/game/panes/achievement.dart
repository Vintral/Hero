import 'package:flutter/material.dart';

import 'package:hero/providers/settings.dart';

class AchievementPane extends StatelessWidget {
  const AchievementPane({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.primaryContainer,
      shadowColor: Theme.of(context).colorScheme.shadow,
      margin: EdgeInsets.all(Settings.gap),
      child: SizedBox.expand(
        child: Center(
            child: Text("ACHIEVEMENT",
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onPrimaryContainer))),
      ),
    );
  }
}
