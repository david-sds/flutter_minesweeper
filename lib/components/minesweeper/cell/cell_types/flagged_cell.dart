import 'package:flutter/material.dart';
import 'package:flutter_minesweeper/components/minesweeper/cell/cell.dart';
import 'package:flutter_minesweeper/components/minesweeper/cell/cell_shell/cell_shell.dart';
import 'package:flutter_minesweeper/components/minesweeper/cell/cell_state/cell_state.dart';

class FlaggedCell extends StatelessWidget {
  const FlaggedCell({
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
      image: Image.asset('assets/images/flag.png'),
      color: Colors.yellow,
      onRightClick: () => onChangeState(
        state.copyWith(type: CellStateTypes.question),
      ),
    );
  }
}
