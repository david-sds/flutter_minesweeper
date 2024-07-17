import 'package:flutter/material.dart';
import 'package:flutter_minesweeper/components/minesweeper/cell/cell_shell/cell_shell.dart';
import 'package:flutter_minesweeper/components/minesweeper/cell/cell_state/cell_state.dart';

class ExplodedCell extends StatelessWidget {
  const ExplodedCell({
    required this.state,
    required this.onChangeState,
    required this.cellSize,
    super.key,
  });

  final double cellSize;
  final CellState state;
  final void Function(CellState) onChangeState;

  @override
  Widget build(BuildContext context) {
    return CellShell(
      state: state,
      size: cellSize,
      image: Image.asset('assets/images/bomb.png'),
      color: Colors.red,
    );
  }
}
