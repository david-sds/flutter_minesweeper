import 'package:flutter/material.dart';
import 'package:flutter_minesweeper/app/theme.dart';
import 'package:flutter_minesweeper/components/minesweeper/minesweeper.dart';
import 'package:flutter_minesweeper/modules/system_configuration_module.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final config = context.read<SystemConfigurationModule>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Minesweeper'),
        leading: IconButton(
          icon: Observer(
            builder: (context) {
              return Icon(
                config.brightness == Brightness.light
                    ? Icons.light_mode
                    : Icons.dark_mode,
              );
            }
          ),
          onPressed: () => config.toggleBrightness(),
        ),
      ),
      body: const Minesweeper(
        initialDifficulty: Difficulty.classic,
      ),
    );
  }
}
