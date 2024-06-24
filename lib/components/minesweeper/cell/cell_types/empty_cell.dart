import 'package:flutter/material.dart';
import 'package:flutter_minesweeper/components/minesweeper/cell/cell_shell/cell_shell.dart';
import 'package:flutter_minesweeper/components/minesweeper/cell/cell_state/cell_state.dart';

class EmptyCell extends StatelessWidget {
  const EmptyCell({
    required this.state,
    required this.onChangeState,
    super.key,
  });

  final CellState state;
  final void Function(CellState) onChangeState;

  @override
  Widget build(BuildContext context) {
    return CellShell(
      bombNumber: state.closeCells.bombNumber,
      bombNumberColor: state.closeCells.bombNumberColor,
      onLeftClick: () => onChangeState(state),
      color: Colors.grey,
    );
  }
}
