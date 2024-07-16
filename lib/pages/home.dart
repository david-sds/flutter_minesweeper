import 'package:flutter/material.dart';
import 'package:flutter_minesweeper/components/minesweeper/minesweeper.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Minesweeper'),
      ),
      body: const Minesweeper(
        initialDifficulty: Difficulty.classic,
      ),
    );
  }
}
