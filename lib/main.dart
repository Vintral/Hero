import 'package:flutter/material.dart';

import 'package:logger/logger.dart';

import 'package:hero/screens/game/screen.dart';
import 'package:hero/screens/splash/screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Logger.level = Level.warning;

    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routes: <String, WidgetBuilder>{
        "splash": (context) => const SplashScreen(),
        "game": (context) => const GameScreen(),
      },
      initialRoute: "splash",
    );
  }
}
