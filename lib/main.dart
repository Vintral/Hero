import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hero/screens/create.dart';
import 'package:logger/logger.dart';

import 'package:hero/screens/game.dart';
import 'package:hero/screens/splash.dart';

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
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routes: <String, WidgetBuilder>{
        "splash": (context) => const SplashScreen(),
        "game": (context) => const GameScreen(),
        "create": (context) => const CreateScreen(),
      },
      initialRoute: "splash",
    );
  }
}
