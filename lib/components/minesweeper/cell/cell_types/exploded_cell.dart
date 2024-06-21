import 'package:flutter/material.dart';
import 'package:flutter_minesweeper/components/minesweeper/cell/cell_shell/cell_shell.dart';
import 'package:flutter_minesweeper/components/minesweeper/cell/cell_state/cell_state.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

class ExplodedCell extends StatelessWidget {
  const ExplodedCell({
    required this.state,
    required this.onChangeState,
    super.key,
  });

  final CellState state;
  final void Function(CellState) onChangeState;

  @override
  Widget build(BuildContext context) {
    return const CellShell(
      iconData: Symbols.bomb,
      color: Colors.red,
    );
  }
}
