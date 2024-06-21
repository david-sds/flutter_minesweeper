import 'package:flutter/material.dart';
import 'package:flutter_minesweeper/router/router.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Minesweeper App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.purple,
        ),
        appBarTheme: const AppBarTheme().copyWith(
          color: Colors.blue,
        ),
      ),
      routerConfig: router,
    );
  }
}
