import 'package:flutter/material.dart';
import 'package:flutter_minesweeper/modules/system_configuration_module.dart';
import 'package:flutter_minesweeper/router/router.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:universal_html/html.dart' as html;

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {

  @override
  void initState() {
    html.document.onContextMenu.listen((event) => event.preventDefault());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final config = context.read<SystemConfigurationModule>();
    return Observer(builder: (context) {
      return MaterialApp.router(
        title: 'Flutter Minesweeper App',
        theme: config.theme,
        routerConfig: router,
      );
    });
  }
}
